class GameById {
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
    final MinimumSystemRequirements minimumSystemRequirements;
    final List<Screenshot> screenshots;

    GameById({
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
}

class MinimumSystemRequirements {
    final String os;
    final String processor;
    final String memory;
    final String graphics;
    final String storage;

    MinimumSystemRequirements({
        required this.os,
        required this.processor,
        required this.memory,
        required this.graphics,
        required this.storage,
    });
}

class Screenshot {
    final int id;
    final String image;

    Screenshot({
        required this.id,
        required this.image,
    });
}
