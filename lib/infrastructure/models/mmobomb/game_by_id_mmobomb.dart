class GameByIdMmobomb {
    final int id;
    final String title;
    final String thumbnail;
    final String status;
    final String shortDescription;
    final String description;
    final String gameUrl;
    final String genre;
    final String platform;
    final String publisher;
    final String developer;
    final DateTime releaseDate;
    final String profileUrl;
    final MinimumSystemRequirementsMmobomb minimumSystemRequirements;
    final List<ScreenshotMmobomb> screenshots;

    GameByIdMmobomb({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.status,
        required this.shortDescription,
        required this.description,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.profileUrl,
        required this.minimumSystemRequirements,
        required this.screenshots,
    });

    factory GameByIdMmobomb.fromJson(Map<String, dynamic> json) => GameByIdMmobomb(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        shortDescription: json["short_description"],
        description: json["description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        profileUrl: json["profile_url"],
        minimumSystemRequirements: MinimumSystemRequirementsMmobomb.fromJson(json["minimum_system_requirements"]),
        screenshots: List<ScreenshotMmobomb>.from(json["screenshots"].map((x) => ScreenshotMmobomb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "status": status,
        "short_description": shortDescription,
        "description": description,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "profile_url": profileUrl,
        "minimum_system_requirements": minimumSystemRequirements.toJson(),
        "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
    };
}

class MinimumSystemRequirementsMmobomb {
    final String os;
    final String processor;
    final String memory;
    final String graphics;
    final String storage;

    MinimumSystemRequirementsMmobomb({
        required this.os,
        required this.processor,
        required this.memory,
        required this.graphics,
        required this.storage,
    });

    factory MinimumSystemRequirementsMmobomb.fromJson(Map<String, dynamic> json) => MinimumSystemRequirementsMmobomb(
        os: json["os"],
        processor: json["processor"],
        memory: json["memory"],
        graphics: json["graphics"],
        storage: json["storage"],
    );

    Map<String, dynamic> toJson() => {
        "os": os,
        "processor": processor,
        "memory": memory,
        "graphics": graphics,
        "storage": storage,
    };
}

class ScreenshotMmobomb {
    final int id;
    final String image;

    ScreenshotMmobomb({
        required this.id,
        required this.image,
    });

    factory ScreenshotMmobomb.fromJson(Map<String, dynamic> json) => ScreenshotMmobomb(
        id: json["id"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
    };
}
