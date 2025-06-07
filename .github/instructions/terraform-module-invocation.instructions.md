---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform Module Invocation Guidelines

## The Principle of Intentional Invocation

A module invocation is a declarative stanza that must be structured as a logical narrative, not as an arbitrary list of arguments. Its internal order should descend from the abstract to the specific, starting with the module's identity, then its core purpose, its detailed configuration, and finally its metadata. This consistent structure enhances readability and reduces cognitive load, treating the act of calling a module with the same discipline as writing a well-formed function call or API request.

This principle asserts that a `module` block is a user interface in its own right and is governed by the following:

* **From *Clean Code*, it applies the "Stepdown Rule" and the principle of Vertical Ordering.** A reader's eye should flow logically from top to bottom. The most critical information—what the module *is* and *where it comes from*—must be declared first. The details that modify its behavior follow in a predictable sequence, creating a clean, readable narrative within the block.

* **From Gestalt Psychology, it is a direct application of the Law of Proximity.** Arguments that are conceptually related must be grouped together. All inputs controlling network behavior should be adjacent; all inputs controlling sizing or capacity should form a distinct block. This grouping creates visual and logical patterns that make the module's configuration instantly scannable and easier to comprehend.

* **From UX and Cognitive Science, it respects the need for Consistency and Predictability.** Just as a consistent UI design allows users to navigate new screens intuitively, a consistent ordering within all `module` calls across a project allows developers to understand a module's purpose and configuration without having to mentally re-parse the structure each time. This predictability is a critical factor in creating a maintainable and scalable codebase.

* **From User Experience (UX) Design, it implements the Principle of Progressive Disclosure.** This principle dictates that to prevent overwhelming a user, an interface should only present the essential information and actions upfront. More advanced, complex, or less frequently used options should be hidden, accessible only when a user explicitly chooses to reveal them. It's about managing complexity by presenting information in layers. The prescribed order for a module block is a direct implementation of Progressive Disclosure: Layer 1 (The Essentials) forces you to confront the most critical information first—source, version, and core identity variables. Layer 2 (The Configuration) progressively discloses the detailed configuration arguments that define how the module behaves. Layer 3 (The Advanced Options) reveals the least common and most complex options like `providers` and `depends_on`. By following this order, the module block doesn't overwhelm the reader with every possible input at once, creating an ordered journey from high-level identity to low-level implementation details.

---

## The Prescribed Order of Invocation

To adhere to this principle, every `module` block should be structured in the following, non-negotiable order:

1.  **Source and Version (`source`, `version`):** The absolute first arguments. They answer the most fundamental question: "What code am I running?" The version is inextricably linked to the source and must be its immediate partner.

2.  **Lifecycle and Cardinality (`count`, `for_each`):** The next most critical information. These meta-arguments define *if* and *how many* instances of this module will be created. They control the module's very existence in the resource graph.

3.  **Identity and Naming Arguments:** The primary, required inputs that give the resource its unique identity within your architecture. These are typically variables like `name`, `project_id`, `resource_group_name`, or a specific ID for a parent resource like `vpc_id`. They are the "who" and "what" of the module.

4.  **Primary Configurational Arguments:** The main body of the inputs, which control the core behavior and configuration of the module. These should themselves be grouped thematically (e.g., networking, compute, storage) to satisfy the Law of Proximity. This section answers the question: "How should this module behave?"

5.  **Feature Flags and Boolean Toggles:** Simple boolean flags that enable or disable secondary features (e.g., `enable_monitoring`, `create_public_ip`). Grouping these together provides a quick checklist of the optional capabilities being activated.

6.  **Metadata Arguments (`tags`, `labels`):** Inputs that do not affect the runtime behavior of the resources but are used for classification, cost allocation, and automation. Placing these near the end signifies them as descriptive data applied *to* the configured resource.

7.  **Execution and Dependency Overrides (`depends_on`, `providers`):** The final set of arguments. These are advanced, "meta-meta" configurations that alter the fundamental execution graph and should be used sparingly. Placing them last highlights them as explicit deviations from normal behavior. 