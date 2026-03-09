use Air::Base;
use Air::Functional :BASE;
use Air::Component;

role Air::Plugin::Asciinema does Component {
    #.cast file
    has Str $.filename;

    has $.rows = 12;
    has $.cols = 64;
    has %.responsive = (:cutoff(768), :min-height-lg(320), :min-height-sm(170));

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
            div :class<asciinema>, :id($.url-path);
            script $player;
        ];
    }

    method SCRIPT-LINKS { 'https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.min.js' }
    method STYLE-LINKS  { 'https://cdn.jsdelivr.net/npm/asciinema-player@3/dist/bundle/asciinema-player.css' }

    method STYLE {
        if %!responsive {
            my %r := %!responsive;
            my $style = q:to/END/;
            .asciinema {
              min-height: %MIN-HEIGHT-LG%px;
             }

            @media (max-width: %CUTOFF%px) {
              .asciinema {
                min-height: %MIN-HEIGHT-SM%px;
              }
            END

            $style ~~ s:g/'%CUTOFF%'       /%r<cutoff>/;
            $style ~~ s:g/'%MIN-HEIGHT-LG%'/%r<min-height-lg>/;
            $style ~~ s:g/'%MIN-HEIGHT-SM%'/%r<min-height-sm>/;
            $style;
        }
    }
}

sub asciinema(*@a, *%h) is export { Air::Plugin::Asciinema.new( |@a, |%h ) };

