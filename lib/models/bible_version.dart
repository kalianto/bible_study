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
    this.id,
    this.table,
    this.abbreviation,
    this.language,
    this.version,
    this.infoText,
    this.infoUrl,
    this.publisher,
    this.copyright,
    this.copyrightInfo,
    this.keyTable,
    this.enabled,
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
