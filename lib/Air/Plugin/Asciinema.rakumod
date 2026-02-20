use Air::Functional;
use Hilite;

role Air::Plugin::Hilite does Tag {

    #| code to be highlited
    has Str $.code;
    #| language (from highlight.js + haskell + raku + rakudoc)
    has $.lang = 'raku';

    #! make a stub to consume
    my class Template {
        my class Globals {
            has %.helper;

            method escape {
                use HTML::Escape;
                &escape-html;
            }
        }

        has $.globals = Globals.new;

        method warnings {
            $!globals.helper<add-to-warnings>;
        }
    }
    my class Receptacle {
        has %.data;

        method add-templates(*@a, *%h) {}
        method add-data($ns, %config) {
            %!data{$ns} = %config;
        }
    }

    has $!tmpl = Template.new;
    has $!rctl = Receptacle.new;
    has $!hltr = Hilite.new: :css-lib<pico>;

    #| script, styles from Hilite.rakumod
    has @!js-links;     #list of script src urls
    has $!script;
    has @!css-links;    #list of link href urls
    has $.scss;

    submethod TWEAK {
        $!hltr.enable: $!rctl;

        @!js-links   = $!rctl.data<hilite><js-link>.map: *[0];
        @!js-links  .= map: *.split('=')[1];     #pick the url
        @!js-links  .= map: *.substr(1,*-1);     #rm quote marks
        $!script     = $!rctl.data<hilite><js>[0][0];

        @!css-links  = $!rctl.data<hilite><css-link-dark>.map: *[0];
        @!css-links .= map: *.split('=')[1];     #pick the url
        @!css-links .= map: *.substr(1,*-1);     #rm quote marks
        $!scss       = $!rctl.data<hilite><scss>[0][0];
    }

    #| .new positional takes Str $code
    multi method new(Str $code, *%h) {
        self.bless:  :$code, |%h;
    }

    method warnings { note $!tmpl.warnings }

    multi method HTML {
        my %prm = :contents($!code), :$!lang, :!label;
        $!hltr.templates<code>(%prm, $!tmpl);
    }

    method SCRIPT-LINKS { @!js-links }
    method SCRIPT       { $!script }

    method STYLE-LINKS  { @!css-links }
    method SCSS         { $!scss }
}

sub hilite(*@a, *%h) is export { Air::Plugin::Hilite.new( |@a, |%h ) };
