import 'dart:async';
import 'dart:io';

import 'package:firebase/firebase_io.dart';
import 'package:github/server.dart';

GitHub github;
String firebaseAuth;
PullRequest currentPullRequest;

String firebaseRoot = "https://flutter-web-controller.firebaseio.com/flutter/pulls";

main(List<String> arguments) async {
  Map<String, String> env = Platform.environment;
  github = createGitHubClient(auth: new Authentication.withToken(env["GITHUB_TOKEN"]));

  firebaseAuth = arguments[1];
  String branchName = arguments[0];

  FirebaseClient fbClient = new FirebaseClient(firebaseAuth);

  List<PullRequest> prsList = await getPullRequests();
  currentPullRequest = prsList.firstWhere((p) => p.head.ref == branchName);

  String rootPath = "${firebaseRoot}.json";

  Map<String, Map<String, String>> projectsData = await fbClient.get(rootPath);
  String projectToDeploy;

  await projectsData.forEach((String key, Map<String, String> value) async {
    if (value["branch"] == branchName) {
      // this has already been deployed.
      // deploy again
      projectToDeploy = value["name"];
    } else {
      if (value["branch"] != null) {
        bool oldBranch = await isBranchOld(value["branch"]);
        if (oldBranch) {
          await fbClient.patch("${firebaseRoot}/$key.json", {"branch": null});
        }
      }
    }
  });

  if (projectToDeploy == null) {
    await projectsData.forEach((String key, Map<String, String> value) async {
      if (projectToDeploy != null) {
        return;
      }
      if (value["branch"] == null) {
        projectToDeploy = value["name"];
        await fbClient.patch("${firebaseRoot}/$key.json", {"branch": branchName});
        await postLinkToGithub(projectToDeploy, currentPullRequest);
      }
    });
  }

  print(projectToDeploy);
}

Future<bool> isBranchOld(String branchName) async {
  List<PullRequest> pullRequests = await getPullRequests();
  return !pullRequests.any((p) => p.head.ref == branchName);
}

Future<List<PullRequest>> getPullRequests() async {
  Stream<PullRequest> pullRequests = await github.pullRequests.list(new RepositorySlug.full("flutter/website"));
  return await pullRequests.toList();
}

Future<IssueComment> postLinkToGithub(String projectToDeploy, PullRequest request) async {
  if (request == null) {
    return null;
  }

  IssueComment issueComment = await github.issues.createComment(
      new RepositorySlug.full("flutter/website"),
      request.number,
      "Staging URL Generated At https://${projectToDeploy}.firebaseapp.com . Please allow Travis Build to finish to view the URL.");
  return issueComment;
}
