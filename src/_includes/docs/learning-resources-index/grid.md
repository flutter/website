<section class="card-grid" id="all-resources-grid">
    {%- for item in resources -%}
        <a id="{{ item.name }}"
           data-type="{{ item.type }}"
           data-tags='{{ item.tags | join: ", " }}'
           data-description="{{ item.description }}"
           class="card outlined-card"
           href="{{ item.link.url }}"
           target="_blank"
        >
            {%- if item.imageUrl -%}
                <div class="card-image-holder-material-3">
                    <img src='{{ item.imageUrl }}'>
                </div>
            {%- endif -%}
            <div class="card-leading">
                {%- liquid
                    case item.type
                        when 'codelab'
                            assign pill-color = 'flutter-blue'
                        when 'workshop'
                            assign pill-color = 'flutter-blue'
                        when 'quickstart'
                            assign pill-color = 'purple'
                        when 'demo'
                            assign pill-color = 'purple'
                        else
                            assign pill-color = 'teal'
                    endcase -%}
                <span class="pill-sm {{ pill-color }}">{{ item.type | capitalize }}</span>
                {%- if item.link.label == "Flutter Github" -%}
                    <svg class="monochrome-icon" width="24px" height="24px">
                      <use href="/assets/images/social/github.svg#github"></use>
                    </svg>
                {%- elsif item.link.label == 'Dart Github' -%}
                    <img src="/assets/images/branding/dart/logo.svg" width="24px" alt="Dart logo" />
                {%- elsif item.link.label == 'Flutter docs' -%}
                    <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter logo" width="24px"/>
                {%- elsif item.link.label == 'Dart docs' -%}
                    <img src='/assets/images/branding/dart/logo.svg' alt="Dart icon" width="24px"/>
                {%- elsif item.link.label == "Google Codelab" -%}
                    <svg width="24px" height="24px">
                      <use href="/assets/images/social/google-developers.svg#google-developers"></use>
                    </svg>
                {%- elsif item.link.label == "YouTube" -%}
                    <svg style="color: red" width="24px" height="24px">
                      <use href="/assets/images/social/youtube.svg#youtube"></use>
                    </svg>
                {%- elsif item.link.label == "Medium" -%}
                    <svg class="monochrome-icon" width="24px" height="24px">
                      <use href="/assets/images/social/medium.svg#medium"></use>
                    </svg>
                {%- endif -%}
            </div>
            <div class="card-header">
                <span class="card-title">{{ item.name }}</span>
            </div>
            <div class="card-content">

                {{ item.description }}

            </div>
        </a>
    {%- endfor -%}
</section>
