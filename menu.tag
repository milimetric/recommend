<menu class="ui pointing menu">
    <div class="right menu">
        <div class="item">
            <div class="ui transparent icon input">
            <input type="text"
                   placeholder="name (optional) ..."
                   name="username" />
            <i class="search link icon"></i>
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
    </script>
</menu>
