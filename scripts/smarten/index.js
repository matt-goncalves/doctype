import { readFile } from 'fs/promises';
import { statSync } from 'fs';

function isXml(text) {
  return text.trim().startsWith('<');
}

// Smart quote replacement for outside tag content
function smartenQuotesOutsideTags(xml) {
  const parts = xml.split(/(<[^>]+>)/g);

  return parts.map(part => {
    if (part.startsWith('<') && part.endsWith('>')) {
      return part; // Skip tags and attributes
    }
    return part
      .replace(/---/g, '—')                 // em dash
      .replace(/--/g, '–')                  // en dash
      .replace(/\.{3}/g, '…')               // ellipsis
      .replace(/(\w)'s\b/g, '$1’s')         // possessive 's
      .replace(/(\w)s'\b/g, '$1s’')         // plural possessive
      .replace(/"([^"]+?)"/g, '“$1”')       // double quotes
      .replace(/'([^']+?)'/g, '‘$1’')      // single quotes
      .replace(/(\w)'(\w)/g, '$1’$2'); // e.g., don't → don’t
  }).join('');
}

async function readInput(argv) {
  if (argv.length > 2) {
    const filePath = argv[2];
    try {
      statSync(filePath); // throws if not found
      return await readFile(filePath, 'utf8');
    } catch (err) {
      console.error(`Error reading file: ${err.message}`);
      process.exit(1);
    }
  } else {
    // Read from stdin
    const chunks = [];
    for await (const chunk of process.stdin) {
      chunks.push(chunk);
    }
    return Buffer.concat(chunks).toString('utf8');
  }
}

async function main() {
  const input = await readInput(process.argv);
  const smartened = smartenQuotesOutsideTags(input);
  process.stdout.write(smartened + '\n');
}

main();
