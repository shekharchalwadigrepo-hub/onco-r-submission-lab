# Oncology R Submission Lab

Educational Shiny application and file kit for learning how an oncology
clinical package is assembled in R for an FDA electronic Common Technical
Document (eCTD) submission — the R-side equivalent of a SAS SDTM / ADaM /
TLF / define.xml workflow.

This repository is a teaching aid. It is not a regulatory submission,
not validated software, and not FDA guidance.

## Suggested GitHub repository name

**`onco-r-submission-lab`**

Why this name:

- `onco` — therapeutic area is obvious in search and in a portfolio
- `r` — language is explicit
- `submission` — the job to be done (eCTD package, not a generic dashboard)
- `lab` — signals a learning and practice repo, not a production pipeline

Strong alternates if the name is taken:

| Name | When to use it |
| --- | --- |
| `fda-oncology-r-academy` | If the repo will grow into a course |
| `r-ectd-oncology-kit` | If you want the eCTD folder map to be the headline |
| `admiralonco-submission-workshop` | If the repo stays tightly tied to admiral / admiralonco |

Recommended GitHub settings: Public, description
“Learn the R workflow for FDA oncology study-data packages (SDTM, ADaM, TLFs, ADRG, eCTD).”
Topics: `r`, `shiny`, `fda`, `oncology`, `cdisc`, `adam`, `sdtm`, `pharmaverse`, `clinical-trials`.

## What you can learn here

The app is an interactive lab built around a synthetic 12-subject extract of fictional study ONC301 (metastatic NSCLC, RECIST 1.1). Changing the confirmation window, data cut, population, or PFS censor rule updates the ORR table, the subject rows, the theory text, and the generated program.

1. Standards and FDA study-data expectations (SDTM, ADaM, XPT, define.xml, Dataset-JSON pilots)
2. Oncology SDTM domains (DM, DS, EX, AE, RS, TR, TU, FA and others)
3. Oncology ADaM (ADSL, ADTR, ADRS, ADTTE, ADAE, ADCM, and efficacy parameters)
4. RECIST 1.1 parameters used in analysis (BOR, ORR, PFS, OS, DOR)
5. TLF programs, transport files, reviewer’s guides, and the Module 5 folder tree
6. Traceability, ADRG reproduction steps, and what the R Consortium pilots actually showed

## Run the app

R 4.1 or newer is assumed.

```r
install.packages(c("shiny", "bslib", "DT"))
shiny::runApp(".")
```

From a shell:

```bash
Rscript -e 'shiny::runApp(".", host = "127.0.0.1", port = 3838, launch.browser = TRUE)'
```

## Repository layout

```text
onco-r-submission-lab/
├── app.R                         # Shiny learning application
├── DESCRIPTION                   # Package metadata (app-as-package friendly)
├── NAMESPACE
├── README.md
├── LICENSE
├── NEWS.md
├── CONTRIBUTING.md
├── .gitignore
├── .github/workflows/app-check.yml
├── R/content.R                   # Teaching content used by the app
└── inst/
    ├── ectd/m5-folder-map.md     # Module 5 study-data tree
    └── templates/                # Starter programs you can copy into a study repo
        ├── 01_adsl_oncology.R
        ├── 02_adrs_recist.R
        ├── 03_adtte_os_pfs.R
        ├── 04_export_xpt.R
        ├── 05_tlf_orr_km.R
        ├── 06_adrg_outline.md
        └── 07_study_package_readme.md
```

## Important boundaries

- FDA accepts study data in CDISC formats described in the Study Data Technical
  Conformance Guide. Analysis datasets are still expected as SAS transport
  (XPT, Version 5) unless a specific pilot or agreement says otherwise.
  Dataset-JSON is the direction of R Consortium Pilots 5+, not the default rule.
- R Consortium Pilots 1–3 showed that R programs for TLFs, a Shiny app, and
  ADaM generation can pass through the eCTD gateway and be reviewed. That is
  feasibility evidence, not a blanket endorsement of every package or workflow.
- Company SOPs, a quality management system, and a documented ADRG still govern
  a real submission. Copying these templates into an NDA or BLA is not enough.
- No patient-level data are included. Examples use synthetic column names only.

## Further reading (primary sources)

- FDA Study Data Technical Conformance Guide
- FDA Clinical Trial Endpoints for the Approval of Cancer Drugs and Biologics
- CDISC SDTMIG and ADaMIG, and the Oncology Therapeutic Area User Guide material
- R Consortium Submissions Working Group pilots (Pilot 1 TLFs, Pilot 2 Shiny, Pilot 3 ADaM)
- pharmaverse: admiral, admiralonco, xportr, metacore, metatools, datasetjson, logrx, pkglite
