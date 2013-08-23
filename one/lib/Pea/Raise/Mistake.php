<?php

namespace Pea\Raise;

/**
 * This exception should only be raised when the error is a result
 * of a mistake in client code or in the configuration.
 */
class Mistake extends \Exception\RuntimeException
{

}
