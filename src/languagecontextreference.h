/*
 * Copyright © 2017 Andrew Penkrat
 *
 * This file is part of Liri Text.
 *
 * Liri Text is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Liri Text is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Liri Text.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef LANGUAGECONTEXTREFERENCE_H
#define LANGUAGECONTEXTREFERENCE_H

#include "languagecontext.h"
#include "languagestyle.h"

class LanguageContextReference
{
public:
    LanguageContextReference();
    ~LanguageContextReference();

    QSharedPointer<LanguageContext> context;
    QSharedPointer<LanguageStyle> style;
protected:
    void resolveCircularDeps(QList<LanguageContextReference *> stack);
    template<class ContextType>
    void resolveCircularDeps(QList<LanguageContextReference *> stack, QSharedPointer<ContextType> current);
};

#endif // LANGUAGECONTEXTREFERENCE_H
