# Oncology R Submission Lab
# Interactive theory plus a synthetic NSCLC practical. Not a real submission.

library(shiny)

app_dir <- if (file.exists("R/synthetic_onc301.R")) {
  "."
} else if (file.exists("../R/synthetic_onc301.R")) {
  ".."
} else {
  "."
}
source(file.path(app_dir, "R/synthetic_onc301.R"), local = FALSE)

derive_lab <- function(confirm_days, cut, censor_newtx, population) {
  d <- subjects
  d$CUT <- cut
  d$ITTFL <- "Y"
  d$SAFFL <- ifelse(!is.na(d$TRTSDT), "Y", "N")
  d$in_pop <- if (population == "Safety") d$SAFFL == "Y" else d$ITTFL == "Y"
  gap <- as.numeric(d$CONFIRM - d$FIRST_RESP)
  d$CONFIRMED <- !is.na(d$FIRST_RESP) & !is.na(d$CONFIRM) & gap >= confirm_days & d$CONFIRM <= cut
  d$RESPFL <- ifelse(d$CONFIRMED, "Y", "N")
  d$BOR <- ifelse(d$CONFIRMED, "CR/PR confirmed", ifelse(!is.na(d$PDDT) & d$PDDT <= cut, "PD", "SD/NE or unconfirmed"))

  start <- d$RANDDT
  pd <- ifelse(!is.na(d$PDDT) & d$PDDT <= cut, as.numeric(d$PDDT), NA)
  death <- ifelse(!is.na(d$DTHDT) & d$DTHDT <= cut, as.numeric(d$DTHDT), NA)
  event_dt <- pmin(pd, death, na.rm = TRUE)
  event_dt[is.infinite(event_dt)] <- NA
  newtx <- ifelse(!is.na(d$NEW_THER) & d$NEW_THER <= cut, as.numeric(d$NEW_THER), NA)
  last_ok <- pmin(as.numeric(d$LAST_ADEQ), as.numeric(cut), na.rm = TRUE)

  censor_dt <- last_ok
  censor_why <- rep("Last adequate assessment", nrow(d))
  use_new <- censor_newtx & !is.na(newtx) & (is.na(event_dt) | newtx < event_dt)
  censor_dt[use_new] <- newtx[use_new]
  censor_why[use_new] <- "New anti-cancer therapy"
  has_event <- !is.na(event_dt) & !use_new
  analysis_dt <- ifelse(has_event, event_dt, censor_dt)
  d$CNSR <- ifelse(has_event, 0, 1)
  d$AVAL <- as.numeric(as.Date(analysis_dt, origin = "1970-01-01") - start) / 30.4375
  d$EVNTDESC <- ifelse(has_event, "Progression or death", censor_why)
  d$AVAL <- round(d$AVAL, 1)
  d
}

orr_table <- function(d) {
  x <- d[d$in_pop, c("ARM", "RESPFL")]
  arms <- unique(subjects$ARM)
  rows <- lapply(arms, function(arm) {
    sub <- x[x$ARM == arm, ]
    n <- nrow(sub)
    r <- sum(sub$RESPFL == "Y")
    data.frame(ARM = arm, N = n, Responders = r, ORR = round(100 * r / n, 1), stringsAsFactors = FALSE)
  })
  do.call(rbind, rows)
}

theory_text <- function(topic, confirm_days, censor_newtx) {
  switch(
    topic,
    "Why this package exists" = paste(
      "Study ONC301 is a fictional metastatic NSCLC pivotal trial.",
      "In SAS, the programming group still delivers the same objects a reviewer opens:",
      "SDTM XPT, ADaM XPT, define.xml, cSDRG, ADRG, and the programs.",
      "R changes the language of adsl.r, adrs.r, adtte.r, and the TLF programs.",
      "It does not change the eCTD folder or the RECIST rules in the SAP."
    ),
    "Estimand before code" = paste(
      "Before any derive call, the SAP has to name the population, the endpoint,",
      "the intercurrent events, and the summary. For ONC301 the primary response",
      "estimand is confirmed objective response on the selected population.",
      "PFS is time from randomization to progression or death.",
      "Writing PARAMCD = 'PFS' before those rules are locked is how programs drift from the SAP."
    ),
    "SDTM tumor domains" = paste(
      "TU identifies target, non-target, and new lesions. TR holds the measurements.",
      "RS holds the visit overall response: CR, PR, SD, PD, NE.",
      "ADRS is derived from RS, not typed in by hand. If IRC is used, those RS rows",
      "stay traceable as a separate evaluator and become parameters such as BORIRC,",
      "not a replacement of the investigator value."
    ),
    "ADSL population flags" = paste(
      "ONC301-005 has a randomization date and no treatment start, so ITTFL is Y and SAFFL is N.",
      "That one subject is why the safety ORR and the ITT ORR differ in the lab.",
      "Flags are derived from DM, DS, and EX, then copied onto ADRS and ADTTE.",
      "A TLF must not rebuild the population with its own filter."
    ),
    "Confirmed response" = paste0(
      "The lab currently requires a second response at least ", confirm_days,
      " days after the first, on or before the data cut. Subject ONC301-002 confirms in 19 days,",
      "so a 28-day rule drops them and a 14-day rule keeps them. Subject ONC301-004 confirms",
      "about 75 days later, so both rules keep them. That window is a SAP sentence, then an ADRS rule."
    ),
    "PFS censoring" = paste(
      "PFS is not OS. A living subject without progression is censored at the last adequate assessment,",
      if (censor_newtx) {
        "and this lab is also censoring at new anti-cancer therapy if it falls before the event."
      } else {
        "and this lab is ignoring new anti-cancer therapy, so a later progression still counts as an event."
      },
      "ONC301-008 has new therapy before later follow-up. Toggle the rule and the CNSR flag changes.",
      "The ADRG has to state which rule was submitted."
    ),
    "What the reviewer re-runs" = paste(
      "Pilot 3 showed FDA reviewers can re-run R ADaM and TLF programs when the ADRG is explicit.",
      "For ONC301 the reproduction section would say: restore renv.lock, run adsl.r, adrs.r, adtte.r,",
      "then t-orr.r. Datasets are still written to XPT with xportr unless Dataset-JSON was agreed.",
      "The Shiny lab itself is a teaching tool. It is not the submitted interactive reviewer app."
    )
  )
}

ui <- navbarPage(
  title = "ONC301 R submission lab",
  id = "main_nav",
  collapsible = TRUE,
  header = div(
    style = "background:#e7f3f2; padding:8px 16px; margin-bottom:8px; border-bottom:1px solid #b7d4d1;",
    tags$strong("Interactive lab."),
    " Set the rules on Practical, then open Theory, Resulting code, and eCTD check. Data are synthetic."
  ),
  tabPanel(
    "Practical",
    fluidRow(
      column(
        4,
        wellPanel(
          tags$h4("ONC301 rules"),
          helpText("Fictional phase 3 NSCLC extract, 12 of 420 subjects, RECIST 1.1."),
          dateInput("cut", "Data cut", value = study_meta$cut_default, min = "2023-06-01", max = "2024-06-30"),
          sliderInput("confirm_days", "Confirmation window (days)", min = 14, max = 42, value = 28, step = 7),
          radioButtons("population", "Analysis set", c("ITT", "Safety"), inline = TRUE),
          checkboxInput("censor_newtx", "Censor PFS at new anti-cancer therapy", TRUE),
          radioButtons("param", "Show", c("Response rows", "PFS rows"), inline = TRUE)
        )
      ),
      column(
        8,
        wellPanel(
          tags$h4(textOutput("orr_title", inline = TRUE)),
          tableOutput("orr"),
          tags$p(textOutput("orr_note"))
        ),
        wellPanel(
          tags$h4("Subject-level result"),
          tableOutput("detail")
        )
      )
    )
  ),
  tabPanel(
    "Theory",
    fluidRow(
      column(
        4,
        wellPanel(
          radioButtons("topic", "Topic, tied to the practical rules", theory_topics)
        )
      ),
      column(
        8,
        wellPanel(
          tags$h4(textOutput("topic_title")),
          textOutput("topic_body"),
          tags$hr(),
          tags$p(tags$em(
            "Change the confirmation window or the PFS censor on Practical, then come back. This panel uses those choices."
          ))
        )
      )
    )
  ),
  tabPanel(
    "Resulting code",
    wellPanel(
      tags$h4("Teaching program generated from the current rules"),
      helpText("Copy into a study repo only after the SAP text matches these arguments. admiral calls are the production shape, not run inside this lab."),
      tags$pre(
        style = "background:#102126; color:#e7f2ef; padding:12px; white-space:pre-wrap;",
        textOutput("code")
      )
    )
  ),
  tabPanel(
    "eCTD check",
    wellPanel(
      tags$h4("Mark the files you would put in the ONC301 sequence"),
      checkboxGroupInput(
        "files",
        NULL,
        c(
          "tabulations/sdtm/rs.xpt" = "rs",
          "tabulations/sdtm/tr.xpt" = "tr",
          "tabulations/sdtm/tu.xpt" = "tu",
          "tabulations/sdtm/define.xml" = "sdef",
          "tabulations/sdtm/csdrg.pdf" = "csdrg",
          "analysis/adam/datasets/adsl.xpt" = "adsl",
          "analysis/adam/datasets/adrs.xpt" = "adrs",
          "analysis/adam/datasets/adtte.xpt" = "adtte",
          "analysis/adam/datasets/define.xml" = "adef",
          "analysis/adam/programs/adrs.r" = "pr",
          "analysis/adam/programs/adtte.r" = "pt",
          "analysis/adam/adrg.pdf" = "adrg"
        ),
        selected = c("adsl", "adrs")
      ),
      tags$h4(textOutput("gate")),
      htmlOutput("gaps")
    )
  ),
  tabPanel(
    "Check yourself",
    wellPanel(
      tags$h4("Five questions from the ONC301 path"),
      radioButtons("q1", quiz$q[1], c(quiz$a[1], quiz$wrong1[1], quiz$wrong2[1])),
      radioButtons("q2", quiz$q[2], c(quiz$wrong1[2], quiz$a[2], quiz$wrong2[2])),
      radioButtons("q3", quiz$q[3], c(quiz$wrong2[3], quiz$wrong1[3], quiz$a[3])),
      radioButtons("q4", quiz$q[4], c(quiz$a[4], quiz$wrong1[4], quiz$wrong2[4])),
      radioButtons("q5", quiz$q[5], c(quiz$wrong1[5], quiz$a[5], quiz$wrong2[5])),
      actionButton("score", "Score"),
      tags$h4(textOutput("score"))
    )
  )
)

server <- function(input, output, session) {
  lab <- reactive({
    derive_lab(input$confirm_days, input$cut, isTRUE(input$censor_newtx), input$population)
  })

  output$orr_title <- renderText({
    sprintf("Confirmed objective response, %s, window %d days", input$population, input$confirm_days)
  })
  output$orr <- renderTable({
    orr_table(lab())
  })
  output$orr_note <- renderText({
    d <- lab()
    dropped <- d$USUBJID[d$in_pop & !is.na(d$FIRST_RESP) & d$RESPFL == "N"]
    if (length(dropped) == 0) {
      "Every subject with a first response in this population is confirmed under the current window and cut."
    } else {
      paste("Unconfirmed or out of window:", paste(dropped, collapse = ", "))
    }
  })
  output$detail <- renderTable({
    d <- lab()
    d <- d[d$in_pop, ]
    if (input$param == "Response rows") {
      d[, c("USUBJID", "ARM", "SAFFL", "FIRST_RESP", "CONFIRM", "RESPFL", "BOR")]
    } else {
      d[, c("USUBJID", "ARM", "AVAL", "CNSR", "EVNTDESC")]
    }
  })

  output$topic_title <- renderText(input$topic)
  output$topic_body <- renderText({
    theory_text(input$topic, input$confirm_days, isTRUE(input$censor_newtx))
  })

  output$code <- renderText({
    sprintf(paste(
      "# ONC301 teaching extract. Synthetic data only.",
      "confirm_days <- %d",
      "data_cut <- as.Date('%s')",
      "censor_at_new_therapy <- %s",
      "population <- '%s'",
      "",
      "# Production shape, after the SAP matches the arguments above:",
      "# adrs <- derive_param_confirmed_bor(adrs, window = confirm_days)",
      "# adtte <- derive_param_tte(",
      "#   dataset_adsl = adsl,",
      "#   start_date = RANDDT,",
      "#   event_conditions = list(pd_or_death),",
      "#   censor_conditions = list(last_adequate%s),",
      "#   set_values_to = exprs(PARAMCD = 'PFS', PARAM = 'Progression Free Survival')",
      "# )",
      "# xportr_write(adtte, 'analysis/adam/datasets/adtte.xpt')",
      sep = "\n"
    ),
    input$confirm_days,
    format(input$cut),
    if (isTRUE(input$censor_newtx)) "TRUE" else "FALSE",
    input$population,
    if (isTRUE(input$censor_newtx)) ", new_therapy" else ""
    )
  })

  output$gate <- renderText({
    need <- c("rs", "tr", "tu", "sdef", "csdrg", "adsl", "adrs", "adtte", "adef", "pr", "pt", "adrg")
    have <- input$files
    sprintf("Package check: %d of %d required files selected", sum(need %in% have), length(need))
  })
  output$gaps <- renderUI({
    labels <- c(
      rs = "RS response domain", tr = "TR measurements", tu = "TU lesion identifiers",
      sdef = "SDTM define.xml", csdrg = "cSDRG", adsl = "ADSL", adrs = "ADRS",
      adtte = "ADTTE", adef = "ADaM define.xml", pr = "adrs.r", pt = "adtte.r", adrg = "ADRG"
    )
    need <- names(labels)
    missing <- need[!need %in% input$files]
    if (length(missing) == 0) {
      return(tags$p("This set covers the ONC301 efficacy path a reviewer would look for. Still not a publishing validation."))
    }
    tags$ul(lapply(labels[missing], function(x) tags$li(paste("Missing:", x))))
  })

  output$score <- renderText({
    input$score
    isolate({
      ans <- c(input$q1, input$q2, input$q3, input$q4, input$q5)
      n <- sum(ans == quiz$a)
      sprintf("%d / 5. The expected choices are the dataset and the document, not the display tool.", n)
    })
  })
}

shinyApp(ui, server)
