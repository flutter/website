// #docregion All
/// Representation of the JSON data returned by the Wikipedia API.
class Summary {
  /// Returns a new [Summary] instance.
  Summary({
    required this.titles,
    required this.pageId,
    required this.extract,
    required this.extractHtml,
    this.thumbnail,
    this.originalImage,
    required this.lang,
    required this.dir,
    this.description,
    required this.url,
  });

  /// The title information of this article.
  final TitlesSet titles;

  /// The page ID of this article.
  final int pageId;

  /// The first few sentences of the article in plain text.
  final String extract;

  /// The first few sentences of the article in HTML format.
  final String extractHtml;

  /// A thumbnail-sized version of the article's primary image, if available.
  final ImageFile? thumbnail;

  /// The original full-sized article's primary image, if available.
  final ImageFile? originalImage;

  /// The language code of the article's content, such as "en" for English.
  final String lang;

  /// The text directionality of the article's content, such as "ltr" or "rtl".
  final String dir;

  /// A description of the article, if available.
  final String? description;

  /// The URL of the page.
  final String url;

  /// Whether this article has an image.
  bool get hasImage => originalImage != null && thumbnail != null;

  /// Returns a new [Summary] instance and imports its values from a JSON map
  static Summary fromJson(Map<String, Object?> json) {
    return switch (json) {
      {
        'titles': final Map<String, Object?> titles,
        'pageid': final int pageId,
        'extract': final String extract,
        'extract_html': final String extractHtml,
        'thumbnail': final Map<String, Object?> thumbnail,
        'originalimage': final Map<String, Object?> originalImage,
        'lang': final String lang,
        'dir': final String dir,
        'description': final String description,
        'content_urls': {
          'desktop': {'page': final String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageId: pageId,
          extract: extract,
          extractHtml: extractHtml,
          thumbnail: ImageFile.fromJson(thumbnail),
          originalImage: ImageFile.fromJson(originalImage),
          lang: lang,
          dir: dir,
          description: description,
          url: url,
        ),
      {
        'titles': final Map<String, Object?> titles,
        'pageid': final int pageId,
        'extract': final String extract,
        'extract_html': final String extractHtml,
        'lang': final String lang,
        'dir': final String dir,
        'description': final String description,
        'content_urls': {
          'desktop': {'page': final String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageId: pageId,
          extract: extract,
          extractHtml: extractHtml,
          lang: lang,
          dir: dir,
          description: description,
          url: url,
        ),
      {
        'titles': final Map<String, Object?> titles,
        'pageid': final int pageId,
        'extract': final String extract,
        'extract_html': final String extractHtml,
        'lang': final String lang,
        'dir': final String dir,
        'content_urls': {
          'desktop': {'page': final String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageId: pageId,
          extract: extract,
          extractHtml: extractHtml,
          lang: lang,
          dir: dir,
          url: url,
        ),
      _ => throw FormatException('Could not deserialize Summary, json=$json'),
    };
  }

  @override
  String toString() =>
      'Summary['
      'titles=$titles, '
      'pageId=$pageId, '
      'extract=$extract, '
      'extractHtml=$extractHtml, '
      'thumbnail=${thumbnail ?? 'null'}, '
      'originalImage=${originalImage ?? 'null'}, '
      'lang=$lang, '
      'dir=$dir, '
      'description=$description'
      ']';
}

// Image path and size, but doesn't contain any Wikipedia descriptions.
// #docregion ImageFile
class ImageFile {
  /// Returns a new [ImageFile] instance.
  ImageFile({required this.source, required this.width, required this.height});

  /// The URI of the original image.
  final String source;

  /// The width of the original image.
  final int width;

  /// The height of the original image.
  final int height;

  /// The file extension of the image, or 'err' if one can't be determined.
  String get extension {
    final extension = getFileExtension(source);
    // By default, return a non-viable image extension.
    return extension ?? 'err';
  }

  /// Returns a JSON map representation of this [ImageFile].
  Map<String, Object?> toJson() {
    return <String, Object?>{
      'source': source,
      'width': width,
      'height': height,
    };
  }

  /// Returns a new [ImageFile] instance with its values populated from [json].
  static ImageFile fromJson(Map<String, Object?> json) {
    if (json case {
      'source': final String source,
      'height': final int height,
      'width': final int width,
    }) {
      return ImageFile(source: source, width: width, height: height);
    }
    throw FormatException('Could not deserialize OriginalImage, json=$json');
  }

  @override
  String toString() =>
      'OriginalImage[source_=$source, width=$width, height=$height]';
}
// #enddocregion ImageFile

// #docregion TitlesSet
class TitlesSet {
  /// Returns a new [TitlesSet] instance.
  TitlesSet({
    required this.canonical,
    required this.normalized,
    required this.display,
  });

  /// The non-prefixed DB key for the article.
  ///
  /// Might contain changes such as underscores instead of spaces.
  /// Best suited for making request URIs, but still requires percent-encoding.
  final String canonical;

  /// The [normalized title](https://www.mediawiki.org/wiki/API:Query#Example_2:_Title_normalization)
  /// of the article.
  final String normalized;

  /// The title as it should be displayed to the user.
  final String display;

  /// Returns a new [TitlesSet] instance with its values populated from [json].
  static TitlesSet fromJson(Map<String, Object?> json) {
    if (json case {
      'canonical': final String canonical,
      'normalized': final String normalized,
      'display': final String display,
    }) {
      return TitlesSet(
        canonical: canonical,
        normalized: normalized,
        display: display,
      );
    }
    throw FormatException('Could not deserialize TitleSet, json=$json');
  }

  @override
  String toString() =>
      'TitlesSet['
      'canonical=$canonical, '
      'normalized=$normalized, '
      'display=$display'
      ']';
}
// #enddocregion TitlesSet

String? getFileExtension(String file) {
  final segments = file.split('.');
  if (segments.isNotEmpty) return segments.last;
  return null;
}

const acceptableImageFormats = ['png', 'jpg', 'jpeg'];

// #enddocregion All
