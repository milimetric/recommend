<Recommend class="ui">

    <div class="ui centered nine column grid">
        <div class="row">
            <h2 class="header">Articles Recommended for Translation</h2>
        </div>

        <div class="stackable row">
            <div class="three wide column">
                <h3>From</h3>
                <select class="ui personalize dropdown">
                    <option>English</option>
                    <option disabled>(more coming soon)</option>
                </select>
            </div>
            <div class="one wide bottom aligned column">
            </div>
            <div class="one wide bottom aligned column">
                <i class="ui big right arrow icon"></i>
            </div>
            <div class="one wide bottom aligned column">
            </div>
            <div class="three wide column">
                <h3>To</h3>
                <select class="ui personalize dropdown">
                    <option>Spanish</option>
                    <option disabled>(more coming soon)</option>
                </select>
            </div>
        </div>

        <div class="row"></div>

        <div class="ui centered grid container tight cards">

            <div each={ articles } class="card"
                onmouseover={ hoverIn }
                onmouseout={ hoverOut }>

                <a onclick={ preview }>
                    <img src={ thumbnail } class="ui left floated image" />
                    <h3>{ title }</h3>
                    <span class="meta">viewed { pageviews } times recently</span>
                </a>
                <span class={ hidden: !hovering }>
                    <button class="ui top right corner icon button" onclick={ remove }>
                        <i class="remove icon"></i>
                    </button>
                </span>
            </div>
        </div>
    </div>

    <preview></preview>

    <script>
        this.articles = [
            { pageviews: 2900, title: 'Tropical_Storm_Brenda_(1960)' },
            { pageviews: 1021, title: 'Apollo–Soyuz_Test_Project' },
            { pageviews: 1200, title: 'Napoleon' },
            { pageviews: 900, title: 'HMS_Bellerophon_(1786)' },
        ];

        var thumbQuery = 'https://en.wikipedia.org/w/api.php?action=query&pithumbsize=50&format=json&prop=pageimages&titles=';

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

        remove (e) {
        }

        preview (e) {
            riot.mount('preview', {
                articles: self.articles,
                title: e.item.title,
            });
        }

        this.articles.forEach(detail);

        this.on('mount', function (){
            $('.ui.dropdown').dropdown();
            $('.ui.extra .button').popup();
        });

        hoverIn (e) {
            e.item.hovering = true;
        }

        hoverOut (e) {
            e.item.hovering = false;
        }

    </script>
</Recommend>
