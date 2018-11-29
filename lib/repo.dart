class ReposList {
  final List<Repo> repos;

  ReposList({
    this.repos,
  });

  factory ReposList.fromJson(List<dynamic> parsedJson) {

    List<Repo> repos = new List<Repo>();
    repos = parsedJson.map((i)=>Repo.fromJson(i)).toList();

    return new ReposList(
      repos: repos,
    );
  }
}

class Owner {
  final String login;
  final String id;
  final String node_id;
  final String avatar_url;
  Owner({
    this.login,
    this.id,
    this.node_id,
    this.avatar_url
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'],
      id: json['id'].toString(),
      node_id: json['node_id'],
      avatar_url: json['avatar_url'],
    );
  }
}
class Repo {
  final String id;
  final String node_id;
  final String name;
  final String full_name;
  final bool private;
  final Owner owner;
  final String description;
  final String html_url;

  Repo({
    this.id,
    this.node_id,
    this.name,
    this.full_name,
    this.private,
    this.owner,
    this.description,
    this.html_url,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      id: json['id'].toString(),
      node_id: json['node_id'],
      name: json['name'],
      full_name: json['full_name'],
      private: json['private'],
      owner: Owner.fromJson(json['owner']),
      description: json['description'],
      html_url: json['html_url'],
    );
  }
}
