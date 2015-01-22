
exports.color;

/**
 * A readline helper, posing `question` and calling fn with input
 * @param {String} question 
 * @param {Function} fn 
 */

exports.ask = function ask(question, fn){
  var rl = require('readline').createInterface(process.stdin, process.stderr);
  rl.question(question, function (answer) {
    rl.close();
    fn(answer);
  });
}

/**
 * Return indented and colored `string`
 * @param {String} string
 */

exports.highlight = function highlight(string) {
  return '\n' + emphasize(indent(string, 4)) + '\n';
}

/**
 * Return grayed `text`
 * @param {String} text
 * @api private
 */

function emphasize(text) {
  if (exports.color === false) return text;
  return '\033[90m' + text + '\033[0m';
}

/**
 * Indent `string` by `amount`
 * @param {String} string
 * @param {Number} amount
 * @api private
 */

function indent(string, amount) {
  amount = new Array(amount).join(' ');
  return string.split('\n')
    // strip trailing newlines
    .filter(function(line, i, ctx){ return i < ctx.length -1 || line.trim().length })
    .map(function(line){ return amount + line }).join('\n')
}
