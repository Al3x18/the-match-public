import 'package:flutter/material.dart';
import 'package:the_match/utils/globals.dart';

class BuildChampionshipLogo extends StatefulWidget {
  const BuildChampionshipLogo({
    super.key,
    required this.textRow1,
    required this.textRow2,
    required this.logotype,
    this.isDark = false,
  });

  final String textRow1;
  final String textRow2;
  final LOGOTYPE logotype;
  final bool isDark;

  @override
  State<BuildChampionshipLogo> createState() => _ChampionshipLogoState();
}

class _ChampionshipLogoState extends State<BuildChampionshipLogo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LOGO_HORIZONTAL_PADDING),
      child: _buildLogoRow(),
    );
  }

  Widget _buildLogoRow() {
    switch (widget.logotype) {
      case LOGOTYPE.serieA:
        return serieARow();
      case LOGOTYPE.premierLeague:
        return premierLeagueRow();
      case LOGOTYPE.laLiga:
        return laLigaRow();
      case LOGOTYPE.ligue1:
        return ligue1Row();
      case LOGOTYPE.formula1:
        return f1Row();
      case LOGOTYPE.bundesliga:
        return bundesligaRow();
      default:
        return serieARow();
    }
  }

  Row serieARow() {
    return Row(
      children: [
        Image.asset(LOGO_SERIE_A_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.textRow1}\n",
                style: TextStyle(
                  color: widget.isDark ? Colors.grey : Colors.black,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
              TextSpan(
                text: widget.textRow2,
                style: TextStyle(
                  color: widget.isDark ? Colors.white : CUSTOM_BLUE_COLOR,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row premierLeagueRow() {
    return Row(
      children: [
        Image.asset(widget.isDark ? LOGO_PREMIER_LEAGUE_DARK_IMAGE_PATH : LOGO_PREMIER_LEAGUE_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.textRow1}\n",
                style: TextStyle(
                  color: widget.isDark ? Colors.grey : Colors.black,
                  fontSize: 36,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
              TextSpan(
                text: widget.textRow2,
                style: TextStyle(
                  color: widget.isDark ? Colors.white : PREMIER_LEAGUE_COLOR,
                  fontSize: 44,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row laLigaRow() {
    return Row(
      children: [
        Image.asset(widget.isDark ? LOGO_LA_LIGA_DARK_IMAGE_PATH : LOGO_LA_LIGA_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT),
        const SizedBox(width: 15),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.textRow1}\n",
                style: TextStyle(
                  color: widget.isDark ? Colors.grey : Colors.black,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
              TextSpan(
                text: widget.textRow2,
                style: TextStyle(
                  color: widget.isDark ? Colors.white : LA_LIGA_COLOR,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row ligue1Row() {
    return Row(
      children: [
        Image.asset(widget.isDark ? LOGO_LIGUE_1_DARK_IMAGE_PATH : LOGO_LIGUE_1_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.textRow1} ${widget.textRow2}",
                style: TextStyle(
                  color: widget.isDark ? Colors.white : LIGUE_1_COLOR,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

    Row bundesligaRow() {
    return Row(
      children: [
        SizedBox(
          width: 65,
          child: Image.asset(widget.isDark ? LOGO_BUNDES_DARK_IMAGE_PATH : LOGO_BUNDES_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT)),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.textRow1}${widget.textRow2}",
                style: TextStyle(
                  color: widget.isDark ? Colors.white : LIGUE_1_COLOR,
                  fontSize: 30,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row f1Row() {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Image.asset(widget.isDark ? F1_LOGO_DARK_IMAGE_PATH : F1_LOGO_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT),
        ),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.textRow1}${widget.textRow2}",
                style: TextStyle(
                  color: widget.isDark ? Colors.white : F1_COLOR,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
