// typst: preview
// -----------------------------------------------------------------
// uiomasterfp.typ
//
// Conversion of the LaTeX uiomasterfp.sty package (v1.10) to Typst.
// This template provides a function `uiomasterfp` to generate
// the official UiO front page for master's and bachelor's theses.
//
// v1.2 - Corrected markup/code mode syntax error in `if` blocks.
// -----------------------------------------------------------------

// -------------------------------------------------
// HOW TO USE
// -------------------------------------------------
//
// #import "uiomasterfp.typ": uiomasterfp
//
// #show: doc => uiomasterfp(
//   title: "My Amazing Thesis Title",
//   author: "Your Name",
//   lang: "eng",
//   doc
// )
//
// -------------------------------------------------


// -------------------------------------------------
// %% Languages
// -------------------------------------------------
#let strings = (
  eng: (
    faculty: "Faculty of Mathematics and Natural Sciences",
    dept: "Department of Informatics",
    thesis-kind: "Master's thesis",
    bachelor-kind: "Bachelor's thesis",
    sp-name: "ECTS study points",
    words: "words",
    supervisor: "Supervisor",
    supervisors: "Supervisors",
    spring: "Spring",
    autumn: "Autumn",
  ),
  bm: (
    faculty: "Det matematisk-naturvitenskapelige fakultet",
    dept: "Institutt for informatikk",
    thesis-kind: "Masteroppgave",
    bachelor-kind: "Bacheloroppgave",
    sp-name: "studiepoeng",
    words: "ord",
    supervisor: "Veileder",
    supervisors: "Veiledere",
    spring: "Våren",
    autumn: "Høsten",
  ),
  nn: (
    faculty: "Det matematisk-naturvitenskaplege fakultet",
    dept: "Institutt for informatikk",
    thesis-kind: "Masteroppgåve",
    bachelor-kind: "Bacheloroppgåve",
    sp-name: "studiepoeng",
    words: "ord",
    supervisor: "Rettleiar",
    supervisors: "Rettleiarar",
    spring: "Våren",
    autumn: "Hausten",
  ),
)

// -------------------------------------------------
// %% Font Sizes
// -------------------------------------------------
#let std-size = 14pt
#let big-size = 20pt
#let head-size = 32pt

// -------------------------------------------------
// %% Colours
// -------------------------------------------------
#let uiomfp-colors = (
  blue: (
    main: rgb(52.5%, 64.2%, 96.9%),
    light: rgb(90.2%, 92.5%, 100%),
  ),
  orange: (
    main: rgb(99.2%, 79.6%, 52.9%),
    light: rgb(100%, 91.0%, 83.1%)
  ),
  pink: (
    main: rgb(98.4%, 40.0%, 40.0%),
    light: rgb(99.6%, 87.8%, 87.8%),
  ),
  green: (
    main: rgb(48.4%, 88.2%, 67.1%),
    light: rgb(80.8%, 100%, 87.5%),
  ),
  gray: (
    main: rgb(70.0%, 70.0%, 70.0%),
    light: rgb(91.2%, 91.2%, 91.2%),
  ),
  grey: ( // Alias
    main: rgb(70.0%, 70.0%, 70.0%),
    light: rgb(91.2%, 91.2%, 91.2%),
  ),
)

// -------------------------------------------------
// %% Helper function for text block on cover
// -------------------------------------------------
#let cover-text(
  title,
  subtitle,
  author,
  program,
  sp,
  sp-name,
  dept,
  fac,
) = {
  block(height: 18.7cm, {
    // Content is pushed to the top (due to \vfill at end)
    par(justify: false)[
      #text(size: head-size, title)
      #parbreak()

      // Wrap markup content inside a code block `{...}` with brackets `[...]`
      #if subtitle != none {
        [
          #text(size: std-size, subtitle)
          #parbreak()
        ]
      }

      #v(3.5em) // \uiomfp@luft x3

      #text(size: std-size, weight: "bold", author)
      #parbreak()
      #v(1.2em)

      #if program != none {
        [
          #text(size: std-size, program)
          #parbreak()
        ]
      }

      #if sp > 0 {
        [
          #text(size: std-size, "{sp} {sp-name}")
          #parbreak()
        ]
      }

      #v(1.2em)

      #text(size: std-size, dept)
      #parbreak()
      #text(size: std-size, fac)
    ]
    v(1fr) // \vfill
  })
}

// -------------------------------------------------
// %% The main command
// -------------------------------------------------
#let uiomasterfp(
  // --- Options ---
  author: none,
  bachelor: false,
  binding: 0pt,
  colophon: none,
  color: "blue",
  compact: false,
  date: none,
  dept: none,
  fac: none,
  font: "",
  img: none,
  info: "",
  kind: none,
  program: none,
  sp: none,
  subtitle: none,
  supervisor: none,
  supervisors: none,
  title: none,
  words: none,
  lang: "bm",
  // --- Document Body ---
  body
) = {
  // --- Setup that DOESN'T need context ---
  set text(font: font, size: std-size)
  let s = strings.at(lang, default: strings.bm)
  let c = uiomfp-colors.at(color, default: uiomfp-colors.blue)

  // *** FIX HERE ***
  // --- Logic that DOES need context ---
  // Wrap all logic that depends on `document` in a context block.
  context {
    // --- Define variables that need context ---
    let final-author = author
    let final-title = title
    let final-fac = fac
    let final-dept = dept

    let is-bachelor = bachelor
    let (final-kind, final-sp, final-compact) = if is-bachelor {
      (
        s.bachelor-kind,
        if sp == none { 0 } else { sp },
        true,
      )
    } else {
      (
        if kind == none { s.thesis-kind } else { kind },
        if sp == none { 60 } else { sp },
        compact,
      )
    }

    let final-date = if date == none {
      let today = datetime.today()
      let year = today.year()
      let month = today.month()
      let term = if month < 7 { s.spring } else { s.autumn }
      "{term} {year}"
    } else {
      date
    }

    let bind-offset = 9.9mm + binding

    // ---------------------------------
    // %% Page I: The Cover
    // ---------------------------------
    page(
      numbering: none,
      background: rect(width: 100%, height: 100%, fill: c.light),
      {
        place(top + left, {
          if img == none {
            rect(width: 100%, height: 9.27cm, fill: c.main)
          } else {
            image(img, width: 100%, height: 9.27cm, fit: "cover")
          }
        })
        place(top + left, dx: bind-offset, dy: 20.5mm, {
          image("uio-fp-navn-" + "nn" + ".png", height: 12.8mm)
        })
        place(top + left, dx: bind-offset, dy: 80.1mm, {
          rect(
            fill: black,
            outset: 3mm,
            text(white, weight: "bold", " " + final-kind + " "),
          )
        })
        place(bottom + left, dx: 176.4mm, dy: 9.9mm, {
          image("uio-fp-segl.pdf", width: 23.7mm)
        })
        place(bottom + left, dx: bind-offset, dy: 9.9mm, {
          text(size: std-size, final-date)
        })
        place(bottom + left, dx: bind-offset, dy: 9.9mm, {
          cover-text(
            final-title,
            subtitle,
            final-author,
            program,
            final-sp,
            s.sp-name,
            final-dept,
            final-fac,
          )
        })
      },
    )

    // ---------------------------------
    // %% Blank Page (if twoside)
    // ---------------------------------
    // if document.settings.twoside {
    //   page(numbering: none, v(1fr))
    // }

    // ---------------------------------
    // %% Page III: Inner Front Page
    // ---------------------------------
    if not final-compact {
      page(
        numbering: none,
        align(center, {
          v(1fr)
          block(width: 100%, inset: (x: 2cm))[
            #align(center)[
              #text(size: std-size, weight: "bold", final-author)
              #v(1cm)
              #text(size: big-size, final-title)
              #v(1cm)
              #if subtitle != none [
                #text(size: std-size, subtitle)
              ]
              #if words == none {
                [#v(3fr)]
              } else {
                [
                  #v(2fr)
                  #text(size: std-size, "{words} {s.words}")
                  #v(2fr)
                ]
              }
              #if supervisor != none {
                [
                  #text(size: std-size, s.supervisor + ":")
                  #parbreak()
                  #text(size: std-size, supervisor)
                  #v(0.5em)
                ]
              }
              #if supervisors != none {
                [
                  #text(size: std-size, s.supervisors + ":")
                  #parbreak()
                  #text(size: std-size, supervisors)
                  #v(1.0em)
                ]
              }
              #text(size: std-size, info)
            ]
          ]
          v(1fr)
        }),
      )

      // ---------------------------------
      // %% Page IV: Colophon Page
      // ---------------------------------
      if colophon != none {
        page(
          numbering: none,
          align(left, {
            v(1fr)
            colophon
          }),
        )
      // } else if document.settings.twoside {
        // page(numbering: none, v(1fr))
      }
    }

    // ---------------------------------
    // %% Reset counter
    // ---------------------------------
    counter(page).update(1)
  } // <-- End of context block

  // ---------------------------------
  // %% Show body
  // ---------------------------------
  // The 'body' (the document) is appended *after*
  // the context-dependent title pages.
  body
}
