import { XMLParser, XMLBuilder } from 'fast-xml-parser';
import { unified } from 'unified';
import english from 'retext-english';
import smartypants from 'retext-smartypants';
import stringify from 'retext-stringify';
import { XMLValidator } from 'fast-xml-parser';

function preProcess(text) {
  return text.replace(/---/g, '—'); // convert triple dash to em dash before smartypants
}

// Smartens text using retext
async function smarten(text) {
  const pre = preProcess(text);
  const file = await unified()
    .use(english)
    .use(smartypants)
    .use(stringify)
    .process(pre);
  return String(file);
}

// Recursively smarten all string text content in the XML object
async function walkAndSmartenObject(obj) {
  if (typeof obj === 'string') {
    return await smarten(obj);
  }

  if (Array.isArray(obj)) {
    return Promise.all(obj.map(walkAndSmartenObject));
  }

  if (typeof obj === 'object' && obj !== null) {
    const result = {};
    for (const key in obj) {
      result[key] = await walkAndSmartenObject(obj[key]);
    }
    return result;
  }

  return obj;
}

// Reads all text from stdin
async function readStdin() {
  const chunks = [];
  for await (const chunk of process.stdin) {
    chunks.push(chunk);
  }
  return Buffer.concat(chunks).toString('utf8');
}

// === Checker for file type === //
function isXml(input) {

  // Quick heuristic: starts with "<"
  if (!input.startsWith('<')) return false;

  // Optional: validate XML structure (catch garbage that starts with < but isn't XML)
  const validation = XMLValidator.validate(input);
  return validation === true;
}

async function main() {

  try {
    const input = await readStdin();

    if (isXml(input)) {

      const parser = new XMLParser({
        ignoreAttributes: false,
        textNodeName: "#text"
      });
      const parsed = parser.parse(input);

      const smartened = await walkAndSmartenObject(parsed);

      const builder = new XMLBuilder({
        ignoreAttributes: false,
        format: true,
        indentBy: '  ',
        textNodeName: "#text"
      });
      const output = builder.build(smartened);

      process.stdout.write(output + '\n');

    } else {
      function splitMarkdown(text) {
        const regex = /^---\s*\n([\s\S]*?)\n---\s*\n?/;
        const match = text.match(regex);

        if (match) {
          return {
            head: match[1].trim(),
            body: text.slice(match[0].length)
          };
        }

        return {
          head: undefined,
          body: text
        };
      }

      const { head, body } = splitMarkdown(input)
      if (head) {
        const smartened = await smarten(body);
        const finalMarkdown = `---\n${head}\n---\n\n${smartened}`;
        process.stdout.write(finalMarkdown + '\n');
      } else {
        const smartened = await smarten(body);
        process.stdout.write(smartened + '\n');
      }
    }

  } catch (err) {
    console.error("Error:", err.message || err);
    process.exit(1);
  }
}

main();
