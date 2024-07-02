String generateUrl(String url, Map<String, dynamic> params) {
  return url.replaceAllMapped(RegExp(r'{(\w+)}'), (match) {
    String? paramName = match.group(1);
    return params[paramName].toString();
  });
}
