import re
import chromadb

# ChromaDB कनेक्शन (Docker के अंदर)
client = chromadb.HttpClient(host="chromadb", port=8000)
collection = client.get_or_create_collection(name="sql_schema")

# SQL फाइल पार्सिंग
with open("/schema/supermarket_db.sqlite.sql") as f:
    content = f.read()

tables = re.findall(r'CREATE TABLE "(\w+)"\s*\((.*?)\);', content, re.DOTALL)

for idx, (table_name, columns) in enumerate(tables):
    # कॉलम एक्सट्रेक्ट करें
    cols = []
    for line in columns.split('\n'):
        line = line.strip().strip(',')
        if line.startswith('"'):
            col_name = line.split()[0].strip('"')
            cols.append(col_name)

    # डॉक्यूमेंट बनाएं
    doc = f"Table {table_name}: {', '.join(cols)}"

    # ChromaDB में डालें
    collection.add(
        documents=[doc],
        ids=[f"table_{idx}"],
        metadatas=[{"type": "table_schema"}]
    )

print(f"Successfully loaded {len(tables)} tables!")
