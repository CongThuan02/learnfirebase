// ignore_for_file: public_member_api_docs, sort_constructors_first

class A {
  final int? a;
  final int? b;
  final String? c;

  A(this.a, this.b, this.c);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'a': a,
      'b': b,
      'c': c,
    };
  }

  factory A.fromMap(Map<String, dynamic> map) {
    return A(
      map['a'] != null ? map['a'] as int : null,
      map['b'] != null ? map['b'] as int : null,
      map['c'] != null ? map['c'] as String : null,
    );
  }
}
