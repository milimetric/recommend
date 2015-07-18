<Recommend class="ui">

    <div class="ui centered eight column grid">
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
            <div class="two wide bottom aligned column">
                <i class="ui big right arrow icon"></i>
            </div>
            <div class="three wide column">
                <h3>To</h3>
                <select class="ui personalize dropdown">
                    <option>Spanish</option>
                    <option>German</option>
                    <option>French</option>
                    <option disabled>(more coming soon)</option>
                </select>
            </div>
        </div>

        <div class="row"></div>

        <div class="ui row cards">

            <div each={ articles } class="card"
                onmouseover={ hoverIn }
                onmouseout={ hoverOut }>

                <div class="content">
                    <a onclick={ preview }>
                        <img src={ thumbnail } class="ui left floated image" />
                    </a>
                    <a onclick={ preview } class="header">{ title }</a>
                    <div class="meta">
                        <span>viewed { pageviews } times recently</span>
                    </div>
                </div>
                <div class="extra">
                    <div class="ui two bottom attached buttons">
                        <div class="mask" if={ !hovering }></div>
                        <button class="ui button">
                            <i class="remove icon"></i>
                            Skip
                        </button>
                        <button class="ui primary button" onclick={ translate }>
                            <i class="write icon"></i>
                            Translate
                        </button>
                    </div>
                </div>
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

        translate (e) {
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

/*
remove disambig header
skip icon position

everything's a link
gray background cards
left align cards
buttons ew
*/

    </script>
</Recommend>
