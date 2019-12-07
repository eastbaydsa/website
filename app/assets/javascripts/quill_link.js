// Customize the way Quill generates anchor tags.

class Link extends Quill.import('formats/link') {
  static create(value) {
    const node = super.create(value);

    // Default Link adds target="_blank" and rel="noopener noreferrer".
    // The target opens links in a new tab, making it easier to return
    // to the site later; noopener offers some protection against
    // malicious sites redirecting the existing tab; and noreferrer
    // offers some privacy for the person following the link. None of
    // these motivations apply to internal links within the site.
    if(node.href.startsWith(window.location.origin)) {
      node.removeAttribute('rel');
      node.removeAttribute('target');
    }

    return node;
  }
}

Quill.register(Link);
