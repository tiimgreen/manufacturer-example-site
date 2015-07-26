String.prototype.replaceAt = function(index, character) {
  return this.substr(0, index) + character + this.substr(index+character.length);
}

if ($(".add-dropcap").length > 0) {
  var text = $(".add-dropcap").html().trim(),
      dropcap = '<span class="dropcap2 bordered shadow">' + text[0] + '</span>';

  $(".add-dropcap").html(dropcap.concat(text.substr(1)));
}
