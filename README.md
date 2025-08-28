# Mini-SIEM in Microsoft Sentinel

This project is a beginner-friendly Security Information and Event Management (SIEM) lab built in Microsoft Sentinel.  
It ingests Windows Security logs and raises incidents using custom detections.  
The repo includes:
- `detections/` → KQL analytic rules
- `workbooks/` → dashboards
- `runbooks/` → triage guides
- `scripts/` → PowerShell to generate demo events
- `docs/` → screenshots and diagrams
- `.github/workflows/` → CI checks

## Getting Started
1. Onboard a Windows machine to Microsoft Sentinel (via AMA).
2. Run `scripts/generate-events.ps1` to produce sample logs.
3. Import KQL queries in `detections/` as scheduled rules.
4. Import workbooks in `workbooks/` for dashboards.
5. Review incidents in Sentinel.

---
