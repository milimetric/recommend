<Recommend class="ui">

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

                <div class="content">
                    <a onclick={ preview }>
                        <img src={ thumbnail } class="ui left floated image" />
                    </a>
                    <a onclick={ preview } class="header">{ title }</a>
                    <div class="meta">
                        <span>viewed { pageviews } times recently</span>
                    </div>
                </div>
                <div class="ui two bottom attached buttons">
                    <button class="ui button">
                        <i class="remove icon"></i>
                        Skip
                    </button>
                    <button class="ui primary button">
                        <i class="write icon"></i>
                        Translate
                    </button>
                </div>
                <!--div class="ui extra">
                    <button class="ui icon left floated button"
                            data-content="Skip">
                        <i class="remove icon"></i>
                    </button>
                    <button class="ui icon right floated primary button"
                            data-content="Translate">
                        <i class="write icon"></i>
                    </button>
                </div-->
            </div>

        </div>
    </div>

    <div class="ui modal preview">
        <div class="ui centered menu">
            <div class="item" onclick={ left }>
                <i class="huge grey chevron left icon"></i>
            </div>
            <div class="item">
                <div class="ui three quarters scrollable container">
                    <h2 class="ui header preview title"></h2>
                    <div class="preview page"></div>
                </div>
            </div>
            <div class="item" onclick={ right }>
                <i class="huge grey chevron right icon"></i>
            </div>
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
                    <div class="ui primary button">
                        <i class="write icon"></i>
                        Translate
                    </div>
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
                article.hovering = false;
                self.update();

            });
        }

        var mobileRoot = 'http://rest.wikimedia.org/en.wikipedia.org/v1/page/html/';

        preview (e) {
            self.index = -1;
            for (var i=0; i<self.articles.length; i++) {
                if (self.articles[i].title === e.item.title) {
                    self.showIndex = i;
                    self.show();
                    break;
                }
            }
        }

        left (e) {
            if (self.showIndex > 0) {
                self.showIndex --;
                self.show();
            }
        }

        right (e) {
            if (self.showIndex < self.articles.length - 1) {
                self.showIndex ++;
                self.show();
            }
        }

        self.cache = {};
        self.show = function () {
            var showing = self.articles[self.showIndex];

            $.get(mobileRoot + showing.title).done(function (data) {;
                self.showPreview(showing.title, data);
            }).fail(function (data) {
                self.showPreview(showing.title, 'No Internet');
            });
        }

        self.showPreview = function (title, body) {
            $('.preview.title').text(title);
            $('.preview.page').html(body);
            $('.ui.modal.preview').modal('show');
        }

        this.articles.forEach(detail);

        this.on('mount', function (){
            $('.ui.dropdown').dropdown();
            $('.ui.extra .button').popup();
        });
    </script>
</Recommend>
