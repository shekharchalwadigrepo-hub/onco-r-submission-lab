# Study package README (internal)

This file stays in the study programming repository. It is not the ADRG.
The ADRG is the reviewer-facing document; this README is how the team works.

## Order of execution

1. `data-cut.r` freezes SDTM to the database cut.
2. `adsl.r` writes `adsl.xpt`.
3. `adtr.r` and `adrs.r` write tumor and response datasets.
4. `adtte.r` writes OS, PFS, DOR, TTR.
5. TLF programs read only the XPT or the pinned ADaM rds, never live SDTM.

## Naming

- Programs use the dataset name: `adrs.r` produces `adrs.xpt`.
- Parameters are stable codes from the spec (`PFS`, `PFSIRC`, `OS`), not free text.

## What is submitted vs what stays internal

Submitted with Module 5 study data:

- XPT datasets, define.xml, cSDRG, ADRG
- Programs required to reproduce ADaM and the TLFs cited in the CSR
- Package manifest the ADRG tells the reviewer to restore

Not a substitute for those files:

- This README, draft specs, QC workbooks, and intermediate rds files
