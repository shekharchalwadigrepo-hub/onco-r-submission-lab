# Analysis Data Reviewer's Guide — outline for an oncology R package

Use the current PHUSE ADRG template. This outline is the content a reviewer
needs when the programs are R rather than SAS. It is not the template itself.

## 1. Introduction

- Study identifier, compound, indication, data cut date
- Standards: SDTMIG version, ADaMIG version, controlled terminology date
- Software: R version, operating system used to produce the submitted outputs
- Statement that analysis datasets are SAS v5 XPT (or Dataset-JSON, if agreed)

## 2. Protocol and analysis decisions that affect data

- Analysis sets (ITT, safety, response-evaluable) and the ADSL flags
- RECIST version, investigator vs independent review, confirmation rule
- Intercurrent events for PFS and OS (new anti-cancer therapy, missed visits)
- Data cut algorithm and the program that applies it

## 3. Analysis datasets

| Dataset | Class | Keys | Created by | Used by |
| --- | --- | --- | --- | --- |
| ADSL | ADSL | USUBJID | adsl.r | All TLFs |
| ADRS | BDS | USUBJID, PARAMCD, ADT | adrs.r | Response tables |
| ADTR | BDS | USUBJID, PARAMCD, ADT | adtr.r | Waterfall |
| ADTTE | BDS | USUBJID, PARAMCD | adtte.r | KM, Cox |

## 4. Data conformance

- xportr checks run, and any accepted findings
- P21 or equivalent community conformance report location
- Known issues (split variables, non-standard parameters) with a rationale

## 5. Programs

- Location: `analysis/adam/programs/`
- Each program lists inputs, outputs, and the ADaM it writes
- Proprietary package: how it was submitted (pkglite text bundle or accepted archive)
- Open-source packages: renv.lock, and the install steps from a clean machine

## 6. Displays

- TLF program index matching CSR appendix identifiers
- Confirmation that figures use the same parameters as the tables

## 7. Reproduction steps

1. Install the R version named above.
2. Restore the library from renv.lock (command included verbatim).
3. Set the working directory to the programs folder. No absolute paths.
4. Run programs in order: adsl.r, adrs.r, adtr.r, adtte.r, then TLF programs.
5. Compare XPT checksums or a listed set of record counts to the submitted files.

## 8. Appendix

- Session info captured by logrx
- Parameter value-level metadata for OS, PFS, DOR, BOR, CBOR
