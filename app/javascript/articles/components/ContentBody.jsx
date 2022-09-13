import { h } from 'preact';
import { articlePropTypes } from '../../common-prop-types';

export const ContentBody = ({ article }) => (
  <div className="crayons-story__plain_html">
    <p dangerouslySetInnerHTML={{ __html: article.safe_plain_html }}></p>
  </div>
);

ContentBody.propTypes = {
  article: articlePropTypes.isRequired,
};

ContentBody.displayName = 'ContentBody';
