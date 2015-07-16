<Translate class="ui">

    <div class="ui centered eight column grid">
        <div class="row">
            <h2 class="header">Articles Recommended for Translation</h2>
        </div>

        <div class="row">
            <div class="three wide column">
                <h3>From</h3>
                <select class="ui personalize dropdown">
                    <option>English</option>
                    <option disabled>(more coming soon)</option>
                </select>
            </div>
            <div class="two wide bottom aligned column">
                <i class="ui big right arrow icon"></i>
            </div>
            <div class="three wide column">
                <h3>To</h3>
                <select class="ui personalize dropdown">
                    <option>French</option>
                    <option>Spanish</option>
                    <option>German</option>
                    <option disabled>(more coming soon)</option>
                </select>
            </div>
        </div>

        <div class="row"></div>

        <div class="ui row cards">

            <div each={ articles } class="card">
                <a onclick={ preview }>
                    <img src={ thumbnail } class="ui small left floated image" />
                </a>
                <div class="content">
                    <a onclick={ preview } class="header">{ title }</a>
                    <div class="meta">
                        <span>viewed { pageviews } times recently</span>
                    </div>
                    <!--p>
                        <button class="ui button">
                            Skip
                            <i class="remove icon"></i>
                        </button>
                    </p-->
                </div>
            </div>

        </div>
    </div>

    <div class="ui modal preview">
        <div class="ui three quarters scrollable">
            <div class="ui text container segment preview page"></div>
        </div>
        <div class="ui menu">
            <div class="item">
                <button class="ui button">
                    Skip
                    <i class="remove icon"></i>
                </button>
            </div>
            <div class="right menu">
                <div class="item">
                    <div class="ui primary button">Translate</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        this.articles = [
            { pageviews: 2900, title: 'Tropical_Storm_Brenda_(1960)' },
            { pageviews: 1021, title: 'Apollo–Soyuz_Test_Project' },
            { pageviews: 1200, title: 'Napoleon' },
            { pageviews: 900, title: 'HMS_Bellerophon_(1786)' },
        ];

        var thumbQuery = 'https://en.wikipedia.org/w/api.php?action=query&pithumbsize=100&format=json&prop=pageimages&titles=';

        var self = this;
        function detail (article) {
            $.ajax({
                url: thumbQuery + article.title,
                dataType: 'jsonp',
                contentType: 'application/json',

            }).done(function (data) {
                var id = Object.keys(data.query.pages)[0],
                    page = data.query.pages[id];

                article.id = id;
                article.title = page.title;
                article.thumbnail = page.thumbnail.source;
                self.update();

            });
        }

        var mobileRoot = 'http://rest.wikimedia.org/en.wikipedia.org/v1/page/html/';

        preview (e) {
            $.get(mobileRoot + e.item.title).done(function (data) {;
                $('.preview.page').html(data);
                $('.ui.modal.preview').modal('show');
            });
        }

        this.articles.forEach(detail);

        this.on('mount', function (){
            $('.ui.dropdown').dropdown();
        });
    </script>
</Translate>
