/*
 * This file is part of "SnipSnap Radeox Rendering Engine".
 *
 * Copyright (c) 2002 Stephan J. Schmidt, Matthias L. Jugel
 * All Rights Reserved.
 *
 * Please visit http://radeox.org/ for updates and contact.
 *
 * --LICENSE NOTICE--
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 * --LICENSE NOTICE--
 */

package org.snipsnap.semanticweb.rss;

import java.util.List;

import org.snipsnap.app.Application;
import org.snipsnap.feeder.Feeder;
import org.snipsnap.snip.Snip;
import org.snipsnap.snip.SnipSpace;
import org.snipsnap.snip.SnipSpaceFactory;
import org.snipsnap.snip.storage.query.Query;
import org.snipsnap.snip.storage.query.QueryKit;

/*
 * Generates a feed of comment snips from a space which can then be
 * serialized to RSS, RDF, Atom, ...
 *
 * @author stephan
 * @team sonicteam
 * @author Paulo Abrantes
 * @version $Id: NewCommentFeeder.java 1606 2004-05-17 10:56:18Z leo $
 */

public class NewCommentFeeder implements Feeder {
  private SnipSpace space;
  
  private Query commentQuery = new Query() {
      public boolean fit(Object object) {
        return isComment((Snip) object);
      }
    };

  public NewCommentFeeder() {
    space = SnipSpaceFactory.getInstance();
  }
  
  public String getName() {
    return "comments";
  }

  public List getFeed() {
    List changed = space.getChanged();
    return QueryKit.query(changed, commentQuery);
  }

  public Snip getContextSnip() {
	    String startName = Application.get().getConfiguration().getStartSnip();
	    return space.load(startName);
  }

  public void setContextSnip(Snip snip) {
	  // Do nothing
  }

  public boolean isComment(Snip snip) {
    return (snip.getName().indexOf("comment") >=0);
  }

 }
