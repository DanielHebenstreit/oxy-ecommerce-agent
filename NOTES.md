# NOTES.md

## How to run

1. Clone the repository

2. Create a `.env` file with the following variables:

   ```
   OPENAI_API_KEY=your_api_key

   POSTGRES_HOST=postgres
   POSTGRES_PORT=5432
   POSTGRES_USER=demo
   POSTGRES_PASSWORD=demo
   POSTGRES_DATABASE=demo
   ```

3. Start the application:

   ```
   docker compose up
   ```

4. Open the Oxy UI in your browser (e.g. http://localhost:3000)

5. Interact with the configured agent via the UI

---

## Assumptions

* The dataset consists only of the provided `orders.csv` and `customers.csv`
* “Order Total” is treated as the main revenue proxy

---

## Problems Encountered

* Initial issues with Docker setup and ensuring Oxy connects to the intended Postgres instance
* SQL execution errors caused by trailing semicolons (`;`) in generated Oxy queries
* Early versions of the agent exhibited largely hallucinations
## Solutions

* Standardized service naming and correct Flags in Docker Compose to ensure correct database resolution
* Updated agent instructions to avoid trailing semicolons in SQL queries, which resolved execution errors
* Improved prompt engineering to explicitly constrain the agent to only use available tables and columns and provide fallback responses when data is unavailable
---

## Limitations of the Current Setup

* Agent performance depends heavily on semantic layer quality
* Error handling by Oxy can be unclear (e.g., failing SQL execution feedback, hallucination)
* Limited transparency in how the agent constructs queries
* While Oxy allows defining example queries/tests, these are not automatically executed as part of startup or a CI workflow
* Semantic definitions are currently implemented in the view files (`orders.view.yml`, `customers.view.yml`), while the centralized `semantics.yml` layer remains unused

---

## What I Would Improve With More Time

* Improve prompt engineering for more robust edge-case handling
* Define a set of structured test queries and formalize these as reusable test cases within Oxy
* Establish a lightweight validation process to regularly re-run these queries and verify correctness and expand test coverage to include edge cases (e.g., missing dimensions) to ensure the agent consistently avoids hallucination
* Refine the semantic layers by improving measure definitions, relationships, and naming to reduce ambiguity and improve agent reliability
* Add and refine an explicit `semantics.yml` to better describe dimensions, measures, and relationships for the LLM
* Populate `semantics.yml` in addition to the existing view-based semantics to provide a more centralized semantic layer
