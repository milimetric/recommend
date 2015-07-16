<Recommend class="ui centered page grid container">
    <div each={ articles } class="seven wide column">
        <a onclick={ preview } class="ui image huge label">
            <img src={ thumbnail } class="ui small left floated image" />
            { title }
            <div class="ui vertical labeled icon buttons detail">
                <button class="ui button">
                    Like
                    <i class="thumbs outline up icon"></i>
                </button>
                <button class="ui button">
                    Dislike
                    <i class="thumbs outline down icon"></i>
                </button>
            </div>
        </a>
    </div>

    <div class="ui modal preview">
        <div class="ui three quarters scrollable">
            <div class="ui text container segment preview page"></div>
        </div>
        <div class="ui menu">
            <div class="item">Less</div>
            <div class="item">More</div>
            <div class="right menu">
                <div class="item">
                    <div class="ui primary button">Translate</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        this.articles = [
            { title: 'Tropical_Storm_Brenda_(1960)' },
            { title: 'Apollo–Soyuz_Test_Project' },
            { title: 'Napoleon' },
            { title: 'HMS_Bellerophon_(1786)' },
        ];

        var thumbQuery = 'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&titles=';

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
    </script>
</Recommend>
