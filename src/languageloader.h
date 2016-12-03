/*
 * Copyright © 2016 Andrew Penkrat
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

#ifndef LANGUAGELOADER_H
#define LANGUAGELOADER_H

#include <QString>
#include <QXmlStreamReader>
#include <QHash>
#include <QMimeType>

#include "languagecontextcontainer.h"
#include "languagedefaultstyles.h"
#include "languagemetadata.h"

class LanguageLoader
{
public:
    LanguageLoader();
    LanguageLoader(QSharedPointer<LanguageDefaultStyles> defaultStyles);
    ~LanguageLoader();
    QSharedPointer<LanguageContextContainer> loadMainContextById(QString id);
    QSharedPointer<LanguageContextContainer> loadMainContextByMimeType(QMimeType mimeType, QString filename);
    QSharedPointer<LanguageContextContainer> loadMainContext(QString path);
    LanguageMetadata loadMetadata(QString path);
protected:
    void parseMetadata(QXmlStreamReader &xml, LanguageMetadata &metadata);
    ContextDPtr parseContext(QXmlStreamReader &xml, QString langId);
    QSharedPointer<LanguageStyle> parseStyle(QXmlStreamReader &xml, QString langId);
    void parseDefineRegex(QXmlStreamReader &xml);
    QString resolveRegex(QString pattern);

    QHash<QString, ContextDPtr> knownContexts;
    QHash<QString, QSharedPointer<LanguageStyle>> knownStyles;
    QHash<QString, QString> knownRegexes;
};

#endif // LANGUAGELOADER_H
