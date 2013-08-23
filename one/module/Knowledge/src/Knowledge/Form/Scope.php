<?php

namespace Knowledge\Form;

use Pea\Form\Form;

class Scope extends Form
{
        public function setupForm()
        {
			$this->add(array(
                'name' => 'id',
                'attributes' => array(
                    'type'  => 'hidden',
                ),
            ));
            $this->add(array(
                'name' => 'title',
                'attributes' => array(
                    'type'  => 'text',
                ),
                'options' => array(
                    'label' => 'Title',
                ),
            ));
            $this->add(array(
                'name' => 'submit',
                'attributes' => array(
                    'type'  => 'submit',
                    'value' => 'Go',
                    'id' => 'submitbutton',
                ),
            ));
        }
}
