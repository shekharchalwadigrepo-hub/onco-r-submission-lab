# Synthetic teaching extract for study ONC-301.
# Not real patients. A 12-subject slice of a fictional metastatic NSCLC trial.

study_meta <- list(
  studyid = "ONC301",
  title = "Phase 3, metastatic NSCLC, Drug X versus docetaxel",
  design = "1:1 randomized, RECIST 1.1, investigator and IRC",
  n_full = 420,
  n_lab = 12,
  sap = "ORR by confirmed CR/PR; PFS and OS from randomization",
  cut_default = as.Date("2024-06-30")
)

# One row per subject. Dates are ISO strings so the file stays plain text.
subjects <- data.frame(
  USUBJID = sprintf("ONC301-%03d", 1:12),
  ARM = c("Drug X", "Drug X", "Drug X", "Drug X", "Drug X", "Drug X",
          "Docetaxel", "Docetaxel", "Docetaxel", "Docetaxel", "Docetaxel", "Docetaxel"),
  RANDDT = as.Date(c(
    "2023-02-01", "2023-02-10", "2023-03-01", "2023-03-15", "2023-04-02", "2023-04-20",
    "2023-02-05", "2023-02-18", "2023-03-08", "2023-03-22", "2023-04-06", "2023-05-01"
  )),
  TRTSDT = as.Date(c(
    "2023-02-08", "2023-02-16", "2023-03-06", "2023-03-20", NA, "2023-04-25",
    "2023-02-12", "2023-02-24", "2023-03-14", "2023-03-28", "2023-04-12", "2023-05-08"
  )),
  FIRST_RESP = as.Date(c(
    "2023-04-05", "2023-05-01", NA, "2023-06-01", NA, "2023-07-10",
    "2023-04-20", NA, "2023-06-15", NA, NA, "2023-07-20"
  )),
  CONFIRM = as.Date(c(
    "2023-05-10", "2023-05-20", NA, "2023-08-15", NA, "2023-08-12",
    "2023-05-25", NA, NA, NA, NA, "2023-08-25"
  )),
  PDDT = as.Date(c(
    "2023-11-01", "2024-01-15", "2023-07-01", NA, NA, "2024-02-01",
    "2023-08-01", "2023-09-01", "2023-10-01", "2023-12-01", NA, "2024-03-01"
  )),
  DTHDT = as.Date(c(
    NA, "2024-05-01", "2023-09-01", NA, NA, NA,
    "2023-12-15", NA, "2024-01-20", "2024-04-01", NA, NA
  )),
  LAST_ADEQ = as.Date(c(
    "2024-05-01", "2023-12-01", "2023-06-15", "2024-06-01", "2023-05-01", "2024-01-15",
    "2023-07-15", "2023-08-15", "2023-09-15", "2023-11-15", "2024-06-10", "2024-02-15"
  )),
  NEW_THER = as.Date(c(
    NA, NA, NA, "2024-03-01", NA, NA,
    NA, "2023-10-01", NA, NA, NA, NA
  )),
  stringsAsFactors = FALSE
)

theory_topics <- c(
  "Why this package exists",
  "Estimand before code",
  "SDTM tumor domains",
  "ADSL population flags",
  "Confirmed response",
  "PFS censoring",
  "What the reviewer re-runs"
)

quiz <- data.frame(
  q = c(
    "Which file does FDA still expect for analysis datasets, unless a catalog entry says otherwise?",
    "Confirmed objective response is usually programmed as which kind of object?",
    "PFS and OS belong in which ADaM dataset?",
    "A sensitivity that uses IRC instead of investigator response should be stored as:",
    "Which document tells the reviewer the R version and the exact run order?"
  ),
  a = c("SAS v5 transport (.xpt)", "An ADRS parameter, plus a flag used in the TLF", "ADTTE", "A separate parameter, such as PFSIRC", "ADRG"),
  wrong1 = c("A Shiny app", "A note in the CSR only", "ADAE", "An overwrite of the investigator parameter", "The program header comment"),
  wrong2 = c("An HTML table", "A column on DM only", "EX", "A second USUBJID", "define.xml alone"),
  stringsAsFactors = FALSE
)
