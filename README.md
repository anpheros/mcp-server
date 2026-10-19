# Anpheros FHIR MCP server: health data for AI agents

**A hosted Model Context Protocol (MCP) server for HL7 FHIR R4 health data.** Connect Claude, Cursor, VS Code or any
MCP client to a FHIR API with 30 synthetic patients, and let the agent search records, build AI-ready patient
context, read International Patient Summaries, validate FHIR resources and import lab reports.

- Endpoint: `https://platform.anpheros.com/mcp` (streamable HTTP)
- Official MCP Registry: [`com.anpheros/fhir`](https://registry.modelcontextprotocol.io/v0/servers?search=com.anpheros/fhir)
- Auth: a sandbox API key (`X-API-Key` or `Authorization: Bearer`), or OAuth with a consent screen (OAuth currently connects sandbox records)
- Docs-only server, no account needed: `https://platform.anpheros.com/mcp/docs`

The server code runs in the Anpheros platform; this repository holds its registry entry ([`server.json`](server.json)),
client configurations and documentation.

## Quick start in 2 minutes

1. **Get a free sandbox key** on the [dashboard](https://platform.anpheros.com/dashboard/?utm_source=github&utm_medium=readme&utm_content=mcp-server) → **Get a sandbox key** (`sk_test_…`).
2. **Add the server to your client** (pick one below).
3. **Ask:** *"List my sandbox patients, then summarise the lab results of the first one."*

### Claude Code

```bash
claude mcp add --transport http anpheros-fhir https://platform.anpheros.com/mcp --header "X-API-Key: sk_test_…"
```

### Cursor (`~/.cursor/mcp.json`)

```json
{
  "mcpServers": {
    "anpheros-fhir": {
      "url": "https://platform.anpheros.com/mcp",
      "headers": { "X-API-Key": "sk_test_…" }
    }
  }
}
```

### VS Code (`.vscode/mcp.json`)

```json
{
  "servers": {
    "anpheros-fhir": {
      "type": "http",
      "url": "https://platform.anpheros.com/mcp",
      "headers": { "X-API-Key": "${input:anpheros-key}" }
    }
  },
  "inputs": [{ "id": "anpheros-key", "type": "promptString", "description": "Anpheros sandbox key (sk_test_…)", "password": true }]
}
```

### Claude.ai (custom connector)

Settings → Connectors → **Add custom connector** → `https://platform.anpheros.com/mcp`. Claude signs in with OAuth and
the consent screen shows exactly what it may read (read-only by default). OAuth currently connects sandbox records.

Ready-made files: [`configs/`](configs).

## Tools

| Tool | What it does |
|---|---|
| `list_patients` | the patients this sandbox project can see |
| `get_patient_context` | an AI-ready, provenance-labelled summary of a patient within a token budget |
| `get_patient_summary` | the International Patient Summary (IPS, FHIR `$summary`) |
| `get_timeline` | the record in date order across resource types |
| `get_health_patterns` | what changed and what recurs (trends, deviations), each with evidence and limitations; not diagnoses |
| `get_pattern_evidence` | every resource behind one finding |
| `get_series` | one measurement over time by LOINC code |
| `compare_periods` | whether a measurement differed between two periods |
| `search_fhir` | standard FHIR R4 search |
| `read_fhir_resource` | one FHIR resource, optionally a past version |
| `get_provenance` | who wrote a resource, when and from which system |
| `lookup_code` | LOINC (labs, vitals) and ATC (medicines) codes |
| `search_health_terms` | symptoms, conditions and treatments in 20 languages with ICD-10 / ICD-11 codes |
| `get_health_term` | one catalog entry with codes and names |
| `validate_fhir_resource` | validate a FHIR R4 resource without saving it |
| `create_fhir_resource` | create a FHIR resource in the sandbox |
| `create_patient` | create a made-up test patient |
| `import_lab_report` | a CSV or HL7 v2 lab report → laboratory Observations |
| `sandbox_status` | quotas and state of your sandbox |
| `reset_sandbox` | restore the 30 synthetic patients |

Prompts: `summarize_for_doctor`, `labs_csv_to_fhir`, `build_integration`.

## Safety

- Sandbox keys see synthetic patients only; production keys are refused by the MCP endpoint.
- With OAuth, an agent reaches one person's record only after that person approves it, read-only unless they allow more; they can revoke it at any time.
- Every write records Provenance (`urn:anpheros:mcp`), so AI-written data is never mixed up with clinical facts.
- The server returns records and patterns, not diagnoses or treatment advice.

## Guides

[MCP server guide](https://developers.anpheros.com/guides/mcp?utm_source=github&utm_medium=readme&utm_content=mcp-server) ·
[AI agents and medical data](https://developers.anpheros.com/guides/ai-agents-medical-data?utm_source=github&utm_medium=readme&utm_content=mcp-server) ·
[AI agent access to medical records](https://developers.anpheros.com/guides/ai-agent-access-medical-records?utm_source=github&utm_medium=readme&utm_content=mcp-server) ·
[FHIR sandbox](https://developers.anpheros.com/guides/fhir-sandbox?utm_source=github&utm_medium=readme&utm_content=mcp-server)

Coding agents: [anpheros/agent-skills](https://github.com/anpheros/agent-skills) adds an Agent Skill, a Claude Code plugin, Cursor rules and AGENTS.md.

Apache-2.0 · [anpheros.com](https://anpheros.com/?utm_source=github&utm_medium=readme&utm_content=mcp-server)
