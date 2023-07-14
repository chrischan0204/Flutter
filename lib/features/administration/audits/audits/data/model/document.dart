import 'package:safety_eta/common_libraries.dart';

class Document extends Equatable {
  final String id;
  final String? documentType;
  final String? uri;
  final String? fileName;
  final String? originalFileName;
  final double documentSize;

  const Document({
    required this.id,
    this.documentType,
    this.uri,
    this.fileName,
    this.originalFileName,
    required this.documentSize,
  });

  @override
  List<Object?> get props {
    return [
      id,
      documentType,
      uri,
      fileName,
      originalFileName,
      documentSize,
    ];
  }

  Document copyWith({
    String? id,
    String? documentType,
    String? uri,
    String? fileName,
    String? originalFileName,
    double? documentSize,
  }) {
    return Document(
      id: id ?? this.id,
      documentType: documentType ?? this.documentType,
      uri: uri ?? this.uri,
      fileName: fileName ?? this.fileName,
      originalFileName: originalFileName ?? this.originalFileName,
      documentSize: documentSize ?? this.documentSize,
    );
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] as String,
      documentType:
          map['documentType'] != null ? map['documentType'] as String : null,
      uri: map['uri'] != null ? map['uri'] as String : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      originalFileName: map['originalFileName'] != null
          ? map['originalFileName'] as String
          : null,
      documentSize: map['documentSize'] as double,
    );
  }

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);
}
