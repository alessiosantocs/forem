import { h } from 'preact';
import { articlePropTypes } from '../../common-prop-types';

export const ContentBody = ({ article }) => {
  return (
    <div className="crayons-story__content-preview">
      <div className="inner-content" dangerouslySetInnerHTML={{ __html: article.safe_plain_html }}></div>
      <button className="crayons-btn crayons-btn--ghost crayons-btn--s btn-read-more">Read more</button>
    </div>
  );
};

ContentBody.propTypes = {
  article: articlePropTypes.isRequired,
};

ContentBody.displayName = 'ContentBody';
