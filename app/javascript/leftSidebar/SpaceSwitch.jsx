import { h, Fragment } from 'preact';
import ahoy from 'ahoy.js';
import PropTypes from 'prop-types';
import { Link } from '@crayons';

export const SpaceSwitch = ({ spaces = [], currentSpaceId }) => {
  const switchToSpace = (event) => {
    browserStoreCache('remove');
  };

  // Set current to true if currentSpaceId is the same as the space id
  spaces = spaces.map(
    (space) => ({
      ...space,
      current: space.id === parseInt(currentSpaceId, 10),
    }),
  );

  return (
    <Fragment>
      {spaces.map(({ name, id, current }) =>
        <Link
          key={id}
          title={`${name} tag`}
          onClick={switchToSpace}
          className={current ? 'active' : ''}
          block
          href={`/spaces/${id}`}
          data-no-instant
        >
          {`${name}`}
        </Link>
      )}
    </Fragment>
  );
};

SpaceSwitch.displayName = 'SpaceSwitch';
SpaceSwitch.propTypes = {
  spaces: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired,
      // current: PropTypes.bool.isOptional,
    }),
  ),
};
