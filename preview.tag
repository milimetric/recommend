<preview class="ui modal preview">

    <div class="ui centered menu">
        <div class="item" onclick={ left }>
            <i class="huge grey chevron left icon"></i>
        </div>
        <div class="item">
            <div class="ui three quarters scrollable container">
                <h2 class="ui header">{ title }</h2>
                <div class="preview body"></div>
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

    <script>
        var self = this;

        self.articles = opts.articles || [];
        self.title = opts.title || '';

        self.index = -1;
        for (var i=0; i<self.articles.length; i++) {
            if (self.articles[i].title === self.title) {
                self.showIndex = i;
                break;
            }
        }

        var mobileRoot = 'http://rest.wikimedia.org/en.wikipedia.org/v1/page/html/';

        self.show = function () {
            var showing = self.articles[self.showIndex];

            $.get(mobileRoot + showing.title).done(function (data) {;
                self.showPreview(showing.title, data);
            }).fail(function (data) {
                self.showPreview(showing.title, 'No Internet');
            });
        }

        self.showPreview = function (title, body) {
            self.title = title;
            $('.preview.body').html(body);
            $('.ui.modal.preview').modal('show');
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

        if (isFinite(self.showIndex)) {
            self.show();
        }
    </script>

</preview>
