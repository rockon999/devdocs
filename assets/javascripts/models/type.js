/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
app.models.Type = class Type extends app.Model {
  // Attributes: name, slug, count

  fullPath() {
    return `/${this.doc.slug}-${this.slug}/`;
  }

  entries() {
    return this.doc.entries.findAllBy('type', this.name);
  }

  toEntry() {
    return new app.models.Entry({
      doc: this.doc,
      name: `${this.doc.name} / ${this.name}`,
      path: `..${this.fullPath()}`
    });
  }
};