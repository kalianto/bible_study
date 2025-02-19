class BibleVersion {
  final int id;
  final String table;
  final String abbreviation;
  final String language;
  final String version;
  final String infoText;
  final String infoUrl;
  final String publisher;
  final String copyright;
  final String copyrightInfo;
  final String keyTable;
  final int enabled;

  BibleVersion({
    required this.id,
    required this.table,
    required this.abbreviation,
    required this.language,
    required this.version,
    required this.infoText,
    required this.infoUrl,
    required this.publisher,
    required this.copyright,
    required this.copyrightInfo,
    required this.keyTable,
    required this.enabled,
  });

  factory BibleVersion.fromMapEntry(Map item) {
    return BibleVersion(
      id: item["id"],
      table: item["table"],
      abbreviation: item["abbreviation"],
      language: item["language"],
      version: item["version"],
      infoText: item["info_text"],
      infoUrl: item["info_url"],
      publisher: item["publisher"],
      copyright: item["copyright"],
      copyrightInfo: item["copyright_info"],
      keyTable: 'key_' + item["language"],
      enabled: item["enabled"],
    );
  }
}
