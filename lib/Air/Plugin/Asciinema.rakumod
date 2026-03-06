use Air::Base;
use Air::Functional :BASE;
use Air::Component;

role Air::Plugin::Asciinema does Component {
    #.cast file
    has Str $.filename;

    has $.rows = 12;
    has $.cols = 64;

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
                    rows: %ROWS%,
                    cols: %COLS%
                \}
            );
            END

        $player ~~ s:g/'%ROWS%'/$!rows/;
        $player ~~ s:g/'%COLS%'/$!cols/;


        div [
            div :id($.url-path);
            script $player;
        ];
    }

    method SCRIPT-LINKS { 'https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.min.js' }
    method STYLE-LINKS  { 'https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.css' }
}

sub asciinema(*@a, *%h) is export { Air::Plugin::Asciinema.new( |@a, |%h ) };

