# Series 2- Design (functional / technical)
*Software Evolution Series 2 Assignment*

**Authors:** Sander Leer (Sander.Leer@gmail.com), Tuba Kaya Chomette (tuba_kaya@outlook.com)

----------

# TODO
- **[done]** Dependencies on each level
- **[done]** Cyclomatic complexity on each level
- **[done]** Write text file from Rascal (in JSON format)
- **[done]** HTML page with D3.org graphic
- **[done]** Get information about Rascal webserver and location-click behaviour (Davy)
- Design the graphics
- **[done]** Textbox/Combobox for finding classname
- **[done]** Generate JSON tree for each class info
- **[done]** Read JSON file with metrics from Javascript
- Get maximum and minimum LOC and Dependency count in JSON
- List of important aesthetics (color, diagram, layout, whitespace, typeface)
- List of usability criteria (efficient, effective, usable)
- Motivation of (architectural) view
- Analysis
	- for aesthetics and usability
	- insights in the visualization



## Criteria for judgement
- Scenario
- Criteria for aesthetics, usability and visualization
	- Responsiveness, performance, error prevention (recall-remember), easily identifiable (by colors or size)
- Story why the criteria are met
- Convincing argumentation why the visualization is good (for the purpose)
- Awesomeness


----------


## Goals

The purpose of Series 2 is to visualize the metrics that have been computed in Series 1. We take the software systems of Series 1 as starting point and want to use visualization to increase the insight in these systems as effectively as possible. Typical questions to be answered are:

- What is the global architectural structure of the system?
- What are the dependencies between the components of the system?
- What are the metrics of the various components?
- What is the impact of these metrics in the given architecture?


In this series we intend you to take a researchers’ perspective on software visualization. The goal is to create visualizations that:

1. Satisfy certain aesthetic criteria: the first deliverable of this series is a formulation of these criteria.
-  Satisfy usability criteria: the second deliverable is a formulation of the purpose and usability of the visualization.


The approach we expect is as follows:

- Formulate the criteria as sketched above. You can come up with them yourself, or you can use any source of information for inspiration (cite!).
- Select and motivate at least one architectural view that will be used as the basis for the visualization.
- Map the metrics of Series 1 on this architecture view, make them visible or allow the user to interact such that metrics become available, or both.
- Interpret and evaluate the resulting visualization according to the criteria from 1.

## Assignment

Produce the following deliverables:

1. A list of important aesthetic criteria for the visualization.
-  A list of usability criteria for the visualization.
-  Motivation and description of one or more architectural views
-  Implementation of this view or these views using Rascal. You could/should use facts from M3 to recover architectural information.
-  Implementation of the visual mapping of the metrics of Series 1 on the selected architecture view. Use any visual or interaction means necessary (color and shades, patterns, numbers, edges, popups, hover, inter-action, etc.)
-  Analysis of the result:
   - How does this visualization satisfy the chosen criteria?
   - Which insights does the visualization give in the given software systems? Point out at least three observations that can be concluded from the visualization and could not be easily seen from the source code itself.

## Design

### Motivation

> Information about dependencies and complexity

### View

The view will be on 3 levels: packages, classes and methods.

