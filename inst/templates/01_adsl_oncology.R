# Teaching template — not a validated ADSL program.
# Shows the shape of an oncology subject-level dataset in R.
# Replace the read step with your SDTM paths. Do not submit this file unchanged.

# library(admiral)
# library(dplyr)
# library(metacore)
# library(metatools)
# library(xportr)

# spec <- spec_to_metacore("metadata/adam_spec.xlsx") |>
#   select_dataset("ADSL")

# dm <- read_sdtm("dm")
# ds <- read_sdtm("ds")
# ex <- read_sdtm("ex")

# adsl <- dm |>
#   derive_vars_merged(
#     dataset_add = randomization,
#     new_vars = exprs(ARM, ARMCD, TRT01P, TRT01PN),
#     by_vars = exprs(STUDYID, USUBJID)
#   ) |>
#   derive_vars_dt(new_vars_prefix = "RAND", dtc = RANDDTC) |>
#   derive_vars_dt(new_vars_prefix = "TRTSD", dtc = TRTSDTC) |>
#   derive_vars_dt(new_vars_prefix = "DTH", dtc = DTHDTC) |>
#   mutate(
#     SAFFL = if_else(!is.na(TRTSDT), "Y", "N"),
#     ITTFL = if_else(!is.na(RANDDT), "Y", "N"),
#     FASFL = ITTFL,
#     # Response-evaluable is protocol-specific. Do not hard-code this rule.
#     RESPEVFL = NA_character_
#   )

# adsl <- adsl |>
#   drop_unspec_vars(spec) |>
#   check_variables(spec) |>
#   order_cols(spec) |>
#   xportr_type(spec) |>
#   xportr_length(spec) |>
#   xportr_label(spec)

# xportr_write(adsl, "adam/adsl.xpt")
message("Template only. Wire admiral derivations to your SAP before use.")
