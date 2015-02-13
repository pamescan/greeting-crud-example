library saluditos.book.v1;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import "package:crypto/crypto.dart" as crypto;
import 'package:http/http.dart' as http;
import '../src/common_internal.dart' as common_internal;
import '../common/common.dart' as common;

export '../common/common.dart' show ApiRequestError;
export '../common/common.dart' show DetailedApiRequestError;

/** Books API */
class BookApi {

  final common_internal.ApiRequester _requester;

  BooksResourceApi get books => new BooksResourceApi(_requester);

  BookApi(http.Client client, {core.String rootUrl: "https://crudtesteo.appspot.com/_ah/api/", core.String servicePath: "book/v1/"}) :
      _requester = new common_internal.ApiRequester(client, rootUrl, servicePath);
}


/** Not documented yet. */
class BooksResourceApi {
  final common_internal.ApiRequester _requester;

  BooksResourceApi(common_internal.ApiRequester client) :
      _requester = client;

  /**
   * Crea entidad
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Book].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Book> create(BookReq request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }


    _url = 'Books';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Book.fromJson(data));
  }

  /**
   * Elimina entidad
   *
   * Request parameters:
   *
   * [id] - null
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future destroy(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'Books/' + common_internal.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Obtiene un listado.
   *
   * Request parameters:
   *
   * [limit] - null
   *
   * Completes with a [BooksList].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<BooksList> list({core.int limit}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (limit != null) {
      _queryParams["limit"] = ["${limit}"];
    }


    _url = 'Books';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BooksList.fromJson(data));
  }

  /**
   * Obtiene una entidad
   *
   * Request parameters:
   *
   * [id] - null
   *
   * Completes with a [Book].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Book> show(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }


    _url = 'Books/' + common_internal.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Book.fromJson(data));
  }

  /**
   * Modifica entidad
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - null
   *
   * Completes with a [Book].
   *
   * Completes with a [common.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Book> update(Book request, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = common.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }


    _url = 'Books/' + common_internal.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Book.fromJson(data));
  }

}



/** Not documented yet. */
class Book {
  /** Not documented yet. */
  core.String author;

  /** Not documented yet. */
  core.String content;

  /** Not documented yet. */
  core.String id;

  /** Not documented yet. */
  core.String lastModifiedDate;

  /** Not documented yet. */
  core.String publishedDate;

  /** Not documented yet. */
  core.String title;

  /** Not documented yet. */
  core.String urlImage;


  Book();

  Book.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = _json["author"];
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("lastModifiedDate")) {
      lastModifiedDate = _json["lastModifiedDate"];
    }
    if (_json.containsKey("publishedDate")) {
      publishedDate = _json["publishedDate"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("urlImage")) {
      urlImage = _json["urlImage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = author;
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (lastModifiedDate != null) {
      _json["lastModifiedDate"] = lastModifiedDate;
    }
    if (publishedDate != null) {
      _json["publishedDate"] = publishedDate;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (urlImage != null) {
      _json["urlImage"] = urlImage;
    }
    return _json;
  }
}


/** Not documented yet. */
class BookReq {
  /** Not documented yet. */
  core.String Author;

  /** Not documented yet. */
  core.String Content;

  /** Not documented yet. */
  core.String Image;

  /** Not documented yet. */
  core.String PublishedDate;

  /** Not documented yet. */
  core.String Title;


  BookReq();

  BookReq.fromJson(core.Map _json) {
    if (_json.containsKey("Author")) {
      Author = _json["Author"];
    }
    if (_json.containsKey("Content")) {
      Content = _json["Content"];
    }
    if (_json.containsKey("Image")) {
      Image = _json["Image"];
    }
    if (_json.containsKey("PublishedDate")) {
      PublishedDate = _json["PublishedDate"];
    }
    if (_json.containsKey("Title")) {
      Title = _json["Title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (Author != null) {
      _json["Author"] = Author;
    }
    if (Content != null) {
      _json["Content"] = Content;
    }
    if (Image != null) {
      _json["Image"] = Image;
    }
    if (PublishedDate != null) {
      _json["PublishedDate"] = PublishedDate;
    }
    if (Title != null) {
      _json["Title"] = Title;
    }
    return _json;
  }
}


/** Not documented yet. */
class BooksList {
  /** Not documented yet. */
  core.List<Book> items;


  BooksList();

  BooksList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Book.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}


