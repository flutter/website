// Copyright (c) 2026, the Dart project authors. All rights reserved.
// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/blog.dart';
import 'package:site_shared/components/blog/blog_next_posts.dart';
import 'package:site_shared/components/blog/blog_toc.dart';
import 'package:site_shared/components/blog/post_info.dart';
import 'package:site_shared/components/common/breadcrumbs.dart';
import 'package:site_shared/components/common/client/back_to_top_button.dart';
import 'package:site_shared/util.dart';

import '../components/common/content_image.dart';
import '../utils/scroll_spy.dart';
import 'default_layout.dart';

/// The Jaspr Content layout to use for blog pages,
/// adding elements such as breadcrumbs.
class BlogLayout extends DefaultLayout {
  BlogLayout();

  @override
  String get name => 'blog';

  @override
  List<String> get defaultBodyTags => ['interior', 'blog'];

  @override
  bool get supportsDarkMode => true;

  @override
  List<String> get additionalFontUrls => const [
    'https://fonts.googleapis.com/css2?'
        'family=Roboto+Serif:ital,opsz,wght@'
        '0,8..72,400..700;1,8..72,400..700'
        '&display=swap',
    'https://fonts.googleapis.com/css2?'
        'family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0..1,0'
        '&icon_names=accessibility,account_tree,add,add_circle,alt_route,animation,api,apps,arrow_upward,article,asterisk,auto_awesome,bolt,book_5,bug_report,celebration,center_focus_strong,change_circle,check,check_circle,chevron_left,chevron_right,close,close_small,cloud_download,code,code_blocks,computer,construction,content_copy,dark_mode,data_object,delete,description,desktop_windows,devices,dictionary,diversity_3,docs,download,edit_note,error,expand_more,extension,feedback,filter_list,fit_screen,flutter,grid_view,handyman,info,integration_instructions,inventory_2,keyboard_arrow_down,keyboard_arrow_right,keyboard_arrow_up,language,laptop_mac,layers,library_books,light_mode,lightbulb,link,list,live_tv,markdown,menu,merge_type,mobile,more_vert,night_sight_auto,notifications_active,open_in_new,package_2,palette,phone_iphone,photo_album,photo_library,play_arrow,play_lesson,preview,progress_activity,quick_reference_all,refresh,remove,repeat,rocket_launch,routine,rss_feed,school,science,search,share,smart_toy,sort_by_alpha,speed,storage,swap_horiz,swipe_right,sync,tag,terminal,text_fields,thumb_down,thumb_up,timeline,toggle_on,touch_app,translate,tune,unfold_more,update,vertical_align_top,view_column,view_day,view_module,view_quilt,view_sidebar,warning,web_asset,widgets'
        '&display=block',
  ];

  @override
  Component buildLayout(Page page, Component child) {
    final pageData = page.data.page;
    final pageTitle = pageData['title'] as String? ?? 'Untitled';

    final isPost = page.url.startsWith('/blog/');
    if (isPost && page.data.page['titleBase'] == null) {
      page.apply(
        data: {
          'page': {'titleBase': 'The Flutter Blog'},
        },
      );
    }

    final categories = page.blogCategories;
    final post = isPost
        ? Post.parse(pageData, categories: categories, source: page.url)
        : null;
    final pageCategory = post == null
        ? null
        : categories.firstWhereOrNull(
            (category) => category.slug == post.category,
          );

    return super.buildLayout(
      page,
      main_([
        article(classes: 'content', [
          div(
            classes: ['content', if (isPost) 'post-content'].toClasses,
            attributes: scroll.spyContent,
            [
              div(id: 'site-content-title', [
                if (isPost)
                  PageBreadcrumbs(
                    crumbs: [
                      const BreadcrumbItem(
                        title: 'The Flutter Blog',
                        url: '/blog',
                      ),
                      if (pageCategory != null) ...[
                        BreadcrumbItem(
                          title: pageCategory.label,
                          url: '/blog?category=${pageCategory.slug}',
                        ),
                      ],
                      BreadcrumbItem(
                        title: pageTitle.split(':').first,
                        url: page.url,
                      ),
                    ],
                  ),
                h1(
                  id: 'document-title',
                  attributes: const {'tabindex': '-1'},
                  [
                    if (pageData['underscore_breaker_titles'] == true)
                      ...splitByUnderscore(pageTitle)
                    else
                      .text(pageTitle),
                  ],
                ),
                if (pageData['description'] != null)
                  p(classes: 'blog-subtitle', [
                    .text(pageData['description'] as String),
                  ]),
              ]),
              if (post != null) PostInfo(post: post, url: page.url),
              if (post?.coverImage case final coverImage?
                  when coverImage.showInPost)
                ContentImage(
                  src: coverImage.url,
                  alt: coverImage.alt ?? '',
                  caption: coverImage.caption,
                  isFigure: true,
                  figureClass: 'blog-cover-image',
                  isHighPriority: true,
                ),
              if (isPost) const BlogTableOfContents(),
              child,
              if (isPost)
                BlogNextPosts(currentPage: page, category: pageCategory),
            ],
          ),
        ]),
        if (isPost) const BackToTopButton(),
      ]),
    );
  }
}
