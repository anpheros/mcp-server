# Claude Code: add the Anpheros FHIR MCP server (sandbox key from https://platform.anpheros.com/dashboard/)
claude mcp add --transport http anpheros-fhir https://platform.anpheros.com/mcp --header "X-API-Key: $ANPHEROS_KEY"
