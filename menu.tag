<menu class="ui pointing menu">
    <div class="right menu">
        <div class="ui pointing personalize dropdown link item">
            Personalize <i class="dropdown icon"></i>
            <div class="menu">
              <div class="item">Login to Wikipedia</div>
              <div class="item">With an Article</div>
            </div>
        </div>

        <a each={ opts.items }
           class={ item: true, active: parent.selected === view }
           onclick={ parent.navigate }
        >{ view }</a>
    </div>

    <script>
        this.selected = null

        navigate(e) {
            var url = this.username.value ?
                e.item.view + '/' + this.username.value :
                e.item.view

            riot.route(url)

            this.selected = e.item.view
        }

        this.on('mount', function (){
            $('.ui.dropdown').dropdown();
        });
    </script>
</menu>
