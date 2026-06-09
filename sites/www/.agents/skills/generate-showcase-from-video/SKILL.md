---
name: generate-showcase-from-video
description: Extracts YouTube transcripts and generates professional Flutter showcase blog posts in Markdown format. Use when you need to create a technical marketing case study from a video success story.
---

# Generate showcase from video

## Overview

This skill automates the creation of high-quality Flutter case studies from video interviews or presentations. It fetches the transcript, analyzes the business and technical impact, and formats a blog post suitable for the official Flutter showcase.

## Workflow

### 1. Extract transcript

- Prompt the user for a YouTube URL if one hasn't been provided.
- Execute the transcript extraction script:
  ```bash
  dart run tool/get_video_transcript.dart "<youtube_url>"
  ```

### 2. Analyze & generate

- Analyze the transcript to identify:
  - **Customer/Company name**: Used for the final filename.
  - **Goal**: The problem they were solving (this content should be part of the introductory paragraphs without a header).
  - **Why Flutter**: Reasons for choosing Flutter.
  - **Their solution**: Technical implementation details (mapped to the **Their solution** header).
  - **Key metrics**: Quantifiable wins (Velocity, Reuse, FPS, Team size, etc. - mapped to the **Results** header).
- **CRITICAL**: **DO NOT** use Markdown headers (e.g. `# Header`) in the content. Use **Bold Text** for the section titles as specified in [references/blog-format.md](references/blog-format.md).
- Use the detailed structure and tone guidelines in `references/blog-format.md`.

### 3. Generate image assets

- **MANDATORY**: Request an image (logo or app icon) from the user directly using the chat UI. The user can drag and drop or attach the image to the chat.
- **PROHIBITION**: **DO NOT** use browser tools, search engines, or external websites to find the logo yourself. You must always wait for the user to provide the official asset.
- **Image naming**: Image filenames (logo and card) MUST use underscores to separate words, even if the directory or slug uses hyphens (e.g., `global_citizen_logo.png`).
- Once the image is attached, copy it to `content/showcase/images/third_party/case_studies/<customer_name>/<customer_name_underscored>_logo.png`.
- Run the automatic padding script to generate a perfectly fitted 1450x1080 Showcase Card with a white background:
  ```bash
  dart run tool/generate_showcase_card.dart "content/showcase/images/third_party/case_studies/<customer_name>/<customer_name_underscored>_logo.png" "content/showcase/images/third_party/case_studies/<customer_name>/<customer_name_underscored>_card.png"
  ```

### 4. Output Markdown & update YAML

- Create the final Markdown file directly in the `content/showcase/` directory. **DO NOT** create any standalone blog draft files or scratch `.md` files anywhere else in the project. The only markdown output should be the final showcase file.
- **Filename**: `content/showcase/<customer_name>.md` (e.g., `content/showcase/bmw.md`, `content/showcase/nubank.md`).
- **Strict frontmatter schema**: Ensure the output follows the professional, data-driven tone specified in the guidelines. **MANDATORY**: You MUST follow the exact YAML frontmatter schema defined in [references/blog-format.md](references/blog-format.md).  
  - **YAML safety**: Always quote values that contain colons.
  - **Headline**: The `headline` field MUST be exactly the `company_name` (e.g., `headline: "BMW"`). Do NOT add descriptions or slogans to the headline.
  - Specifically, `successMetrics` must include `perc` and `desc`.
  - Include the date field: `publishDate`.
- Include the `videoEmbedUrl` in the frontmatter if provided, formatting standard YouTube links as `/embed/` links (e.g., `https://www.youtube.com/embed/A3ApoV_QRio`).
- Make sure to map `logo:` and `card:` in the frontmatter to the newly generated `content/showcase/images/third_party/case_studies/<customer_name>/` images.
- Ensure the company is added to `content/showcase/data/companies.yaml` if it doesn't already exist.

## Best practices

- **Human-like tone**: Avoid robotic phrasing. The blog should feel authentic and well-reasoned.
- **Metrics focus**: Always look for numbers. If the video mentions "shipped in 4 months," include it.
- **Safety**: Do not exaggerate claims beyond what is explicitly stated or strongly implied in the transcript.
- **Logos**: Never "guess" or search for a logo online. Brands are very specific about their visual identity; using an incorrect or low-quality logo from the web can damage the professional look of the showcase.
