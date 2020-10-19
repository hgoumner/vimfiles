/*
*   $Id: ac2_gou.c 443 2020-10-17 gou $
*
*   This source code is released for free distribution under the terms of the
*   GNU General Public License.
*
*/

/*
*   INCLUDE FILES
*/
#include "general.h"  /* always include first */
#include "parse.h"    /* always include */

/*
*   FUNCTION DEFINITIONS
*/

static void installAc2_gouRegex (const langType language)
{
	addTagRegex (language, "^C----.*",
		"\\1", "c,controlword,controlwords", NULL);
}

extern parserDefinition* Ac2_gouParser (void)
{
	static const char *const extensions [] = { "cmd", "ac2_gou", "inp", NULL };
	parserDefinition* const def = parserNew ("AC2_GOU");
	def->extensions = extensions;
	def->initialize = installAc2_gouRegex;
	def->regex      = TRUE;
	return def;
}

/* vi:set tabstop=4 shiftwidth=4: */
                        
