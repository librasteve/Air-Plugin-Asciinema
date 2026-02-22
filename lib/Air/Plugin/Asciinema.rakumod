use Air::Base;
use Air::Functional :BASE;
use Air::Component;

role Air::Plugin::Asciinema does Component {
    #.cast file
    has Str $.filename;

    #| .new positional takes Str $filename
    multi method new(Str $filename, *%h) {
        self.bless:  :$filename, |%h;
    }

    multi method HTML {

        my $player = qq:to/END/;
            AsciinemaPlayer.create(
                \'$.filename\',
                document.getElementById(\'$.url-path\'),
                \{
                    autoPlay: true,
                    preload: true,
                    fit: 'width',
                    theme: 'asciinema',
                    loop: true,
                    speed: 1.3,
                    rows: 15,
                    cols: 80,
                    fontSize: \'16px\'
                \}
            );
            END

        div [
            div :id($.url-path);
            script $player;
        ];
    }

    method SCRIPT-LINKS { 'https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.min.js' }
    method STYLE-LINKS  { 'https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.css' }
}

sub asciinema(*@a, *%h) is export { Air::Plugin::Asciinema.new( |@a, |%h ) };

#`[
use Air::Functional :BASE;
use Air::Base;

my $page = Page.new;

$page.html.head.scripts.append: Script.new: :src<https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.min.js>;

$page.html.head.links.append: Link.new: :rel<stylesheet>, :href<https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.css>;

my $player = q:to/END/;
    AsciinemaPlayer.create(
        'static/demos/demo4.cast',
        document.getElementById('player'),
        {
            autoPlay: true,
            preload: true,
            fit: 'width',
            theme: 'asciinema',
            loop: true,
            speed: 1.3
        }
    );
END

$page.main =
    main [
        p el 'simple-greeting', :name<John>, [span 'yo'; span 'ho'];
        div :id<player>;
        script $player;
    ];

site($page).serve;
#]