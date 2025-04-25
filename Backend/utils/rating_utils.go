
package utils

func GetTitleAndDivision(points int) (string, int) {
	switch {
	case points < 700:
		return "Unrated", 3
	case points >= 700 && points <= 999:
		return "Coder", 3
	case points >= 1000 && points <= 1299:
		return "Solver", 3
	case points >= 1300 && points <= 1599:
		return "Strategist", 2
	case points >= 1600 && points <= 1899:
		return "Knight", 2
	case points >= 1900 && points <= 2199:
		return "Ninja", 2
	case points >= 2200 && points <= 2499:
		return "Wizard", 1
	case points >= 2500 && points <= 2799:
		return "Pro", 1
	case points >= 2800:
		return "Elite", 1
	default:
		return "Unrated", 3
	}
}
